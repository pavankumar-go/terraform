# terraform
* code to spin up ec2 instance in stockholm region (because of that extra core in t3.micro for free)

### Steps to run
1. Clone this repository
2. [Install terraform](terraform.io) & `cd ec2`
3. Run `terraform init`
4. Run `terraform plan -out ec2_plan`
5. Run `terraform apply -auto-approve`
6. To terminate the instance run `terraform destroy -auto-approve`

### References 
1. [Terraform Best Practices for AWS users by ozbillwang](https://github.com/ozbillwang/terraform-best-practices)