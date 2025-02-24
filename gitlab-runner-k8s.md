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

# how to install:
```
helm repo add gitlab https://charts.gitlab.io
helm install --namespace gitlab-runners --create-namespace my-gke-runner -f gitlab-kube-runner.yaml gitlab/gitlab-runner
```
