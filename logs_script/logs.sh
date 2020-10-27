while getopts "O:o:" c
do
	case $c in
		O) org_name=$OPTARG ;;
		o) orderers=$(echo $OPTARG | sed 's/,/ /g') ;;
	esac
done


mkdir blockchain-${org_name}

cd blockchain-${org_name}

mkdir peers

cd peers

kubectl -n blockchain-${org_name} logs deployment/peer-1${org_name}-hlf-peer --all-containers=true > peer-1${org_name}-hlf-peer.log

kubectl -n blockchain-${org_name} logs deployment/peer-2${org_name}-hlf-peer --all-containers=true > peer-2${org_name}-hlf-peer.log

cd .. && mkdir orderers

cd orderers

if [ -z "$orderers" ]
then
	echo "no orderers available in ${org_name}"
else
	for element in ${orderers[@]}
	do
		kubectl -n blockchain-${org_name} logs deployment/orderer-${element}${org_name}-hlf-ord --all-containers=true > orderer-${element}${org_name}-hlf-ord.log
	done
fi
