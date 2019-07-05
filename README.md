[![Build Status](https://cloud.drone.io/api/badges/samcre/drone-eks/status.svg?ref=refs/heads/master)](https://cloud.drone.io/samcre/drone-eks)

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
    eks_cluster:
    name:
    image_tag:
    container:
    namespace:    # Optional, default to "default"
    aws_region:   # Optional, default to "us-east-2"
    kind:     # Optional, default to "deploymanet"
    iam_role:   # Optional, default to blank string
```
