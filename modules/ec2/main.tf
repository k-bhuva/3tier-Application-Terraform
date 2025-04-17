resource "aws_instance" "app" {
  count         = 2
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = element(var.subnet_ids, count.index)
  key_name      = var.key_name
  security_groups = [var.ec2_sg_id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install apache2 -y
              echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "app-instance-${count.index}"
  }
}
