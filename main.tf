#Create private key for instance on aws
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAsyzOfbdnvOMjHpqPdZPBMhpiz2+INpUjpXbWWRba4U/0sDCfwrmGqGfDif34jCeEmEd7qGpt27z1T31sfDTsyTeppn/flfnkrQUeuAqiAo052KWGrhIRMK5O/J/pOe2rVB1NrC7yVPi9yoGo/xjlvzs4f5l9WghCPEhGQxhuchWm1zPy6RjcVttskYZDXjEr94YHYVt5/GHM7KcDoDTRz6mhjv4KzkdLdoiZbbx0ROEjagYsJbspC3C0UeKuHld9tzGbOvqTTWsyBcqgTZdrDAa2gOZGElzL9C/0Sd+RDmXc4P0D7uMVohRcgWvDERQfkXw1X1WLzcIwfFwtFuZoLw== rsa-key-20180830"
}

#Create Security group and allow port 22 and 80

resource "aws_security_group" "MySecurityGroup" {
  name        = "MySecurityGroup"
  description = "MySecurityGroup Used in the terraform"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
    # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#Create instance

resource "aws_instance" "my-test-instance" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  key_name		= "deployer-key"
  vpc_security_group_ids = ["${aws_security_group.MySecurityGroup.id}"]
  tags {
    Name = "test-instance"
  }
  # Connect to the server and Install Webserver and add Hello World App

connection {
    user         = "ubuntu"
    private_key  = "${file("C:\\test\\privatekey.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2 -y",
      "sudo systemctl enable apache2",
      "sudo systemctl start apache2",
      "sudo chmod 777 /var/www/html/index.html",
	  "sudo a2enmod rewrite",
	  "sudo a2enmod ssl",
	  "sudo a2ensite default-ssl",
	  "sudo service apache2 restart",
	  "sudo chmod 777 /etc/apache2/apache2.conf",
	  "sudo service apache2 restart",
	  "sudo touch /var/www/html/.htaccess",
	  "sudo chmod 777 /var/www/html/.htaccess"
	  
    ]
  }

  provisioner "file" {
    source = "C:\\test\\index.html"
    destination = "/var/www/html/index.html"
  }
  
  provisioner "file" {
    source = "C:\\test\\.htaccess"
    destination = "/var/www/html/.htaccess"
  }
    provisioner "file" {
    source = "C:\\test\\apache2.conf"
    destination = "/etc/apache2/apache2.conf"
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 775 /var/www/html/index.html",
	  "sudo chmod 775 /var/www/html/.htaccess",
	  "sudo chmod 644 /etc/apache2/apache2.conf",
	  "sudo service apache2 restart"
    ]
  }

 
}


#Attach Elastic Ip
resource "aws_eip" "MyElasticIP" {
  instance = "${aws_instance.my-test-instance.id}"
  
  vpc      = true
    provisioner "local-exec" {
    command = "echo ${aws_eip.MyElasticIP.public_ip} > public-ip.txt"
  }

}


