while getopts "c:n:o:p:O:" i
    do
	    case $i in
	            c) cluster=$OPTARG ;;
		    n) namespace=$OPTARG ;;
		    O) org_name=$OPTARG ;;
		    o) orderers=$(echo $OPTARG | sed 's/,/ /g') ;;
		    p) peers=$(echo $OPTARG | sed 's/,/ /g') ;;
	    esac
    done
    echo ${cluster}
    if [ ${cluster} == "bankema-cluster" ]
    then
        az aks get-credentials --resource-group intain-dev-rg --name ${cluster}
        mkdir ${cluster}
        cd ${cluster}
        mkdir ${namespace}
        cd ${namespace}
        mkdir peers
        cd peers
        if [ -z "$peers" ]
        then
	        echo "no peers available in ${namespace}"
        else
	        for element in ${peers[@]}
	        do
		        kubectl -n ${namespace} logs pod/peer0-0 --all-containers=true > peer-${namespace}.log
	        done
        fi
        cd .. && mkdir orderers
        cd orderers
        if [ -z "$orderers" ]
        then
	        echo "no orderers available in ${namespace}"
        else
	        for element in ${orderers[@]}
	        do
		        kubectl -n ${namespace} logs pod/orderer1-0 --all-containers=true > orderer-${namespace}.log
	        done
        fi
    else
        az aks get-credentials --resource-group intain-dev-rg --name ${cluster}
        mkdir ${cluster}
        cd ${cluster}
        mkdir ${namespace}
        cd ${namespace}
        mkdir peers
        cd peers
        if [ -z "$peers" ]
        then
	        echo "no peers available in ${namespace}"
        else
	        for element in ${peers[@]}
	        do
		        kubectl -n ${namespace} logs deployment/peer-${element}${org_name}-hlf-peer --all-containers=true > peer-${element}${org_name}-hlf-peer.log
	        done
        fi
        cd .. && mkdir orderers
        cd orderers
        if [ -z "$orderers" ]
        then
	        echo "no orderers available in ${namespace}"
        else
	        for element in ${orderers[@]}
	        do
		        kubectl -n ${namespace} logs deployment/orderer-${element}${org_name}-hlf-ord --all-containers=true > orderer-${element}${org_name}.log
	        done
        fi
    fi
