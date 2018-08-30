# terraform-standalone
Standalone single instance project setup with AWS terraform

#Install terraform.

Download terraform from the link below and extract to system32 folder of windows.
C:\Windows\System32

or copy the terraform.exe to C:\Windows\System32

#open command prompt with run as administrator.

create a folder test in C:\

Go to C:\test and git clone the repo or download the repo and extract the contents in C:\test directory.

#Now Lets check the init/plan and apply.


terraform init

terraform plan

terraform apply

#Terraform apply command will perform all the operations in your AWS account.


#To destroy everything:

terraform destroy


#Directory structure:

C:\test    #terraform configurations home directory

main.tf     # file which contains all major operations and configuratios defination.

aws_ami.tf  #this file contains the AMI information which we have used in our project for eg. Ubuntu server LTS 16.04

variables.tf   #This file contains your AWS credentials and aws account information

public-ip.txt   #This file will be generated/updated when all the operations completed. This contains the application ip which you will use in your browser.

Providers.tf    #this file also contains the aws info but picking in form of variables defined in variables.tf file

