# Drone EKS plugin

Drone plugin to get credentials and deploy to a EKS cluster

## Usage

Resource should exist before this plugin can be executed.

```yaml
kind: pipeline
name: default

steps:
- name: deploy_to_eks
  image: samcre/drone-eks
  settings:
    eks_cluster: ${EKS_CLUSTER_NAME}
    name: ${RESOURCE_NAME}
    image_tag: ${IMAGE_TAG_NAME}
    container: ${CONTAINER_NAME}
    namespace: ${K8S_NAMESPACE}  # Optional, default to "default"
    aws_region: ${AWS_REGION}  # Optional, default to "us-east-2"
    kind: ${K8S_RESOURCE_TYPE}  # Optional, default to "deployment"
    iam_role: ${AWS_IAM_ROLE}  # Optional, default to ""
```
