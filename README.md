This repository creates a VPC for the IPS persistent database on AWS.

When invoking `tf apply` the following params needs to be passed in:

```
variable "bastion_ingress_ip" {}
variable "deploy_key_name" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "common_name" {}
variable "db_password" {}
variable "db_user_name" {}
```

The above vars can either be passed in using `-var` directly on the command line or a `.tfvars` file can be setup like so:
```
❯ cat $HOME/.aws/tf-creds.tfvars                                                                                                                                                                  <ons.ash.jindal> [12-Aug 12:44:46]
aws_access_key = "<REDACTED>"
aws_secret_key = "<REDACTED>"
```


For instance, the following command uses a combination of both the approaches, by specifying vars that may change on the command line directly and moving the
vars that contains sensitive information to the .tfvars file so that they do not end up in the shell history:
```
terraform plan      
    -var "bastion_ingress_ip=$(curl --silent  ifconfig.co)"     
    -var "deploy_key_name=ConcDeploy"      
    -var "common_name=ips-tf"       
    -var "db_password=<REDACTED>" 
    -var "db_user_name=<REDACTED>"     
    -var-file=$HOME/.aws/tf-creds.tfvars
```