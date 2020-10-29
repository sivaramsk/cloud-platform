cluster=$1

namespace=$2

echo ${cluster}
    if [ ${cluster} == "bankema-cluster" ]
    then
        az aks get-credentials --resource-group intain-dev-rg --name ${cluster}
        declare -a pod_array
        pod_array=($(kubectl get pods -n ${namespace} | grep 2 | awk '{print $1}'))
        array_length=${#pod_array[@]}
        mkdir ${cluster} && cd ${cluster}
        mkdir ${namespace} && cd ${namespace}
        echo "Total no. of pods in ${namespace}: ${array_length}"
        for (( c=0; c<${array_length}; c++ ))
        do  
          kubectl -n ${namespace} logs pod/${pod_array[c]} --all-containers=true > ${pod_array[c]}.log
          echo "Collected logs of ${pod_array[c]}"
        done
    else
        az aks get-credentials --resource-group intain-dev-rg --name ${cluster}
        declare -a pod_array
        pod_array=($(kubectl get pods -n ${namespace} | grep 1 | awk '{print $1}'))
        array_length=${#pod_array[@]}
        mkdir ${cluster} && cd ${cluster}
        mkdir ${namespace} && cd ${namespace}
        echo "Total no. of pods in ${namespace}: ${array_length}"
        for (( c=0; c<${array_length}; c++ ))
        do  
          kubectl -n ${namespace} logs pod/${pod_array[c]} --all-containers=true > ${pod_array[c]}.log
          echo "Collected logs of ${pod_array[c]}"
        done
    fi
