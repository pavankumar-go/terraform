# terraform
* code to spin up ec2 instance in stockholm region (because of that extra 1 core)

### Steps to run
1. clone repository
2. install terraform from terraform.io
3. run `terraform init`
4. run `terraform plan -out ec2_plan`
5. run `terraform apply -auto-approve`
6. to terminate the instance run `terraform destroy -auto-approve`
