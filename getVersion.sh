curl -s https://raw.githubusercontent.com/IBM/cloud-pak/master/repo/case/ibm-cp-automation/index.yaml > cp-index.yaml

version=$(yq eval '.versions | with_entries(select(.value.appVersion == "22.0.2-IF004")) | keys' cp-index.yaml)


version=$(echo "$version" | tr -d '-')
version="${version#"${version%%[![:space:]]*}"}"
version="${version%"${version##*[![:space:]]}"}"
echo "$version"

curl -L -O "https://github.com/IBM/cloud-pak/raw/master/repo/case/ibm-cp-automation/$version/ibm-cp-automation-$version.tgz"

tar -xvzf "ibm-cp-automation-$version.tgz"

currentDir=$(pwd)
fileName=$(ls -p $currentDir/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs | grep -v /)

tar -xvf $currentDir/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/$fileName

cp $currentDir/cert-kubernetes/descriptors/op-olm/catalog_source.yaml catalog_source.yaml 