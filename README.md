# terraform
* code to spin up ec2 instance in stockholm region (because of that extra core in t3.micro for free)

### Steps to run
1. Clone this repository
2. [Install terraform](terraform.io) & `cd ec2`
3. Run `terraform init`
4. Run `terraform plan -out ec2_plan`
5. Run `terraform apply -auto-approve`
6. To terminate the instance run `terraform destroy -auto-approve`



### To Setup your own VPN Server on AWS EC2
1. Clone `master` branch 
2. generate SSH keys 
   ```
   sshkeygen -t rsa -f newkey
   ```

3. ```
   > terraform init
   > terraform apply -auto-approve
   ```
4. Once resources are created get the instance IP 
   ```
   terraform output
   ```
5. ssh to your instance with the user as `ubuntu`

6. update packages 

7. download the openvpn server installation script from https://raw.githubusercontent.com/Nyr/openvpn-install/master/openvpn-install.sh

8. install it as root user

9. Give all Defaults or else your own choices for prompts

10. IMPORTANT: `disable logging` by vi `/etc/openvpn/server/server.conf` and change `verb` to `0`

11. save & quit and restart openvpn server `systemctl restart openvpn-server@server.service`

12. from your local to download the `xxx.ovpn` file
    ```
    sftp ubuntu@<IP> -i <ssh-key>
    get <filename>.ovpn
    exit
    ```
13. install any vpn applications such as `openvpn connect`
14. upload your downloaded `.ovpn` file and connect 
15. voila !!!
16. Happy visiting cornhub



### References 
1. [Terraform Best Practices for AWS users by ozbillwang](https://github.com/ozbillwang/terraform-best-practices)

### Roadmap
1. Use datasources for getting AMIs instead of hardcoding(ec2/vars.tf/line_21)