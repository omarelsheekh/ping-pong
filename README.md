# ping-pong
this is a test ping-pong service that will be deployed on an eks cluster

## deploying the infra
1. clone this repo
```bash
git clone https://github.com/omarelsheekh/ping-pong
```
2. move to the terraform directory
```bash
cd terraform
```
3. initialize terraform
```bash
terraform init
```
4. export AWS credentials
```bash
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_REGION="eu-west-1"
```
5. terraform plan and apply (consider reviewing the values in `variables.tf` file before procceding)
```bash
terraform plan
terraform apply
```

## deploying ping-pong application
1. export your docker repo and image tag names
```bash
export IMAGE_REPO="username/ping-pong"
export IMAGE_TAG="v1"
```
2. move to the repo root dir
```bash
cd ../
```
3. build and push your docker image
```bash
docker build -t ${IMAGE_REPO}:${IMAGE_TAG} .
docker push ${IMAGE_REPO}:${IMAGE_TAG}
```
4. add the new eks cluster context to your kubeconfig file
```bash
aws eks update-kubeconfig --name cluster_name --kubeconfig ~/.kube/config
```
5. deploy the application with helm
```bash
helm install ping-pong ./helm \
    --set image.repository ${IMAGE_REPO} \
    --set image.tag ${IMAGE_TAG}
```
