#!/bin/bash

create_dir() {
  local dir_name=$1
  mkdir -p $dir_name
}

declare -a ignore_namespaces

ignore_namespaces=("kube-system" "kube-node-lease" "kube-public" "velero" "monitoring" "ingress-controller" "minio")

ignore_ns_length=${#ignore_namespaces[@]}


collect_pod_logs() {
  str=$1
  declare -a arr
  pod_array=($(kubectl get pods -n ${str} | grep 0 | awk '{print $1}'))
  pod_array_length=${#pod_array[@]}
  pod_arr=($(kubectl get pods -n ${str} | grep 1 | awk '{print $1}'))
  pod_arr_length=${#pod_arr[@]}
  if [ $pod_array_length -gt $pod_arr_length ]; then
      length=$pod_array_length
      arr=("${pod_array[@]}")
  else
      length=$pod_arr_length
      arr=("${pod_arr[@]}")
  fi
  create_dir $str
  cd $str
  for (( k=0; k<$length; k++ ))
        do
          kubectl -n ${str} logs pod/${arr[k]} --all-containers=true > ${arr[k]}.log
          echo "Collected logs of ${arr[k]}"
        done
  cd ..
}



get_all_ns() {
  declare -a ns_array
  ns_array=($(kubectl get namespaces | awk '{print $1}'))
  ns_array_length=${#ns_array[@]}
  for (( i=1; i<${ns_array_length}; i++ ))
        do  
          str=${ns_array[i]} 
          if [[ " ${ignore_namespaces[*]} " == *" $str "* ]]; then
              echo "Skipping the logs collection for the pods in $str namespace"
          else
              echo "Collecting the logs of the pods in $str namespace"
              collect_pod_logs $str 
          fi
        done
}

word="current-context"

filename="$HOME/.kube/config"

declare -a currentcontext

currentcontext=($(grep "$word" "$filename"))

cluster_name=${currentcontext[1]}

echo "Cluster name: $cluster_name "

create_dir $cluster_name

cd $cluster_name

get_all_ns 

tar -zcvf $cluster_name_logs.tar.gz $cluster_name
