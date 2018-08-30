# terraform-standalone
Standalone single instance project setup with AWS terraform

# AWS Terraform standalone setup

One Paragraph of project description goes here

## Getting Started
Download install and setup terraform using the instructions give on the link below.

https://www.terraform.io/intro/getting-started/install.html

For windows installation download and unzip the executable in c:\windows\system32

### Prerequisites

after instaling init the terraform

create a project directory.

For example:
c:\terraform

Clone the repo in the project directory or download and unzip the contents of repo in the project directory.

```
git clone https://github.com/prasanthavvaru/terraform-standalone.git
```


Initialize the terraform

```
terraform init
```

init command will download and install the aws plugin.

Create an IAM account with aws-ec2 full access policy and update the Access key and Secret key in variables.tf file.

### Usage

Plan the terraform This will show the list of available changes and resources.

```
terraform plan
```

Apply the changes, This will start the execution of the configurations we have defined.
This will create following:
1. Security group with port 22,80 and 443 allowed traffic.
2. Secret ssh keypair
3. Elsatic ip and assign to instance
4. Ec2 instance with ubuntu LTS 16.04
5. Apache webserver with SSL
6. Helloworld url 

```
terraform apply
```

Once the system deployed, It will give public ip as output.
## Running the tests

Put the output public ip in the browser and this must give output below.


```
Hello world!!! :- prashanth
```

### destroy the resources

To terminate the ec2 instance and app

```
terraform destroy
```


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc

