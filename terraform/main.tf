provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true
  endpoints {
    ec2 = "http://ip10-0-15-4-d0dgrso05akh4glkf950-4566.direct.lab-boris.fr"
  }
}

variable "instance_count" {
  description = "Nombre d'instances à créer"
  type        = number
  default     = 3
}

resource "aws_instance" "demo" {
  count         = var.instance_count
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    Name = "Demo-Instance-${count.index + 1}"
  }
}

output "instance_ids" {
  value = aws_instance.demo[*].id
}
