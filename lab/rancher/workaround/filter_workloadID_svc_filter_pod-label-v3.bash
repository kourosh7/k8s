#!/bin/bash

green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
normal=$(tput sgr0)

for _namespace in `kubectl get ns --no-headers -o custom-columns=":.metadata.name"`
do
  printf "${normal} \n"
  printf "${green}Working with $_namespace namespace${normal}\\n"
  FILTER_WORKLOADID=$(kubectl -n $_namespace get svc -o wide|awk '$7 ~ /workloadID/ {print $0}')

  if [ ! -z "$FILTER_WORKLOADID" ]
  then
    _svcs_workloadid=$(kubectl -n $_namespace get svc -o wide|awk '$7 ~ /workloadID/ {print $1}')

    for _service in $_svcs_workloadid
    do
       printf "${normal} \n"
       printf "${yellow}Found workloadID in $_service service${normal}\\n"
       kubectl -n $_namespace get svc $_service -o wide --no-headers |awk '{print $7}'

       _selectors=$(kubectl -n $_namespace get svc $_service -o wide --no-headers |awk '{print $7}'| sed 's/\,/ /g')

       for _selector in $_selectors
       do

         if [[ "$_selector" == *"workloadID"* ]]
         then
           printf "${yellow}Running PODs labeled with ${normal}\\n"
           kubectl -n $_namespace get po --no-headers --show-labels | awk -v FILTER=$_selector '$0 ~ FILTER {print $1," -- ",$6}'
           printf "${normal} \n"
           printf "${red}Would like update selector $_selector to the $_service ? (Y/N): ${normal}"
           read _answer
           if [[ "$_answer" == "Y" ]]
           then
             _podlabeled=$(kubectl -n $_namespace get po --no-headers --show-labels | awk "/$_selector/"'{print $6}'| sed 's/\,/ /g')
             for _podlabel in $_podlabeled
             do
               if [[ "$_podlabel" != *"workloadID"* ]] && [[ "$_podlabel" != *"pod-template-hash"* ]]
               then
               _newselectors=$(echo $(echo $_podlabel)","$(echo $_newselectors)|sed 's/,$//g')
               fi











             echo $_selector| sed 's/=/ /g' | \
             while read VAR VALUE
             do
               kubectl -n $_namespace get svc $_service -o yaml > bkp-$_date_$_namespace_$_service.yml
               kubectl -n $_namespace patch svc $_service --type json -p='[{"op": "remove", "path": "/spec/selector", "value":{'${VAR}': '${VAR}'}}]'
             done
             printf "${red}... Defined new service selector(s) ...${normal}\\n"
             kubectl -n $_namespace get svc $_service -o wide
           else
             printf "Skipping... \n"
           fi

         fi

       done

    done
  fi
done
