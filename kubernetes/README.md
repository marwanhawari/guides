# Kubernetes guide

## Description
* Kubernetes is a container orchestration tool.
* Automatically manages a "desired state" configuration of servers.

## Architecture
<img src="https://github.com/marwanhawari/guides/blob/main/images/Kubernetes-architecture.png" alt="Kubernetes architecture" width="600"/>
source: https://www.cncf.io/blog/2019/08/19/how-kubernetes-works/

## Basics
* View worker nodes: `kubectl get nodes`
* View running pods: `kubectl get pods`
  * View all pods: `kubectl get pods --all-namespaces`
* Get cluster info: `kubectl cluster-info`
* Each pod has its own internal IP
* Create a `deployment.yaml` file to specify desired state for your clusters. Apply this yaml file using: `kubectl apply -f deployment.yaml`
* View deployments with `kubectl get deployments`
* Edit deployments with `kubectl edit deployment <deployment-name>`
  * Can edit things like the number of pods, the docker images in the pods, and more.
* Create a `service.yaml` file to create a load balancer between your nodes and expose an external API to your cluster for your end users.
* Apply the service just like the deployment before: `kubectl apply -f service.yaml`
* View services using: `kubectl get services`

## Minikube
* Used for testing kubernetes on local machine
* A single node cluster where master and worker processes run on this single node.
* Runs through a virtual box hypervisor
* Docker is pre-installed in minikube
* Start your minikube using `minikube start --vm-driver=virtualbox --disk-size='<allocated-storage:20000mb>'` (if you're using virtualbox for your virtualization)
* Get status of minikube using: `minikube status`
* Configure CPU and RAM limits:
  * CPU: `minikube config set cpus <number-of-cpus:2>` - ex: `minikube config set cpus 4`
  * RAM: `minikube config set memory <amount-of-ram:6000>` - ex: `minikube config set memory 25000` (for a machine with at least 32 GB of RAM).
  * View current config: `minikube config view`
  * Delete and re-start minikub to apply config: `minikube delete`
* Stop minikube (to free up RAM): `minikube stop` and re-start using: `minikube start`
