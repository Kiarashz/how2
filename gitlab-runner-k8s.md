# Gitlab Runner for Kubernetes
This is a sample value file for installing Gitlab runner on Kubernetes.
Content of gitlab-kube-runner.yam could be:
```
gitlabUrl: https://gitlab.com/
rbac:
  create: true
runnerToken: <replace me with the token of created runner in gitlab>
serviceAccount:
  create: true
  name: "gitlab-gke-runner"
```

# How to install:
```
helm repo add gitlab https://charts.gitlab.io
helm install --namespace gitlab-runners --create-namespace my-gke-runner -f gitlab-kube-runner.yaml gitlab/gitlab-runner
```

# Helpful links
1. https://docs.gitlab.com/runner/install/kubernetes/
2. https://docs.gitlab.com/user/packages/container_registry/build_and_push_images/
3. https://docs.gitlab.com/ci/docker/using_docker_build/
