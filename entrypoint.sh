#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

get_kubeconfig() {
  local clustername=$1
  local region=$2
  local rolearn=$3
  
  if [ -n "${rolearn}" ]
  then
    cli="aws eks update-kubeconfig --name ${clustername} --role-arn ${rolearn} --region ${region}"
  fi
  cli="aws eks update-kubeconfig --name ${clustername} --region ${region}"
  
  if ! eval "$cli" &> /dev/null
  then
    echo "There are some errors getting kubeconfig with aws-cli."
  fi
  
}

k8s_resource_exist() {
  local resource=$1
  local namespace=$2
  local rc=0  # Resource exist by default
  
  kubectl get "${resource}" --namespace "${namespace}" &> /dev/null
  rc=$?
  
  echo "${rc}"
}

update_resource() {
  local resource=$1
  local container=$2
  local image=$3
  local namespace=$4
  
  kubectl set image "${resource}" "${container}"="${image}" --namespace "${namespace}"
  
}

RC=0

clustername="${PLUGIN_EKS_CLUSTER}"
name="${PLUGIN_NAME}"
image_tag="${PLUGIN_IMAGE_TAG}"
container="${PLUGIN_CONTAINER}"
namespace="${PLUGIN_NAMESPACE:-"default"}"
region="${PLUGIN_AWS_REGION:-"us-east-2"}"
kind="${PLUGIN_KIND:-"deployment"}"
iam_role="${PLUGIN_IAM_ROLE:-""}"

get_kubeconfig "${clustername}" "${region}" "${iam_role}"

status=$( k8s_resource_exist "${kind}/${name}" "${namespace}" )
if [ "${status}" == 0 ]
then
  update_resource "${kind}/${name}" "${container}" "${image_tag}" "${namespace}"
else
  echo "Resource ${kind}/${name} doesn't exist on namespace ${namespace}"
  RC=1
fi

exit $RC
