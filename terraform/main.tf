provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true
  endpoints {
    ec2 = "http://ip10-0-15-4-d0dgrso05akh4glkf950-4566.direct.lab-boris.fr/"
  }
}

# ==== Déclaration de variables pour personnalisation ====

variable "timestamp" {
  description = "Un identifiant unique pour créer une instance unique"
  type        = string
}

variable "ami_id" {
  description = "AMI aléatoire"
  type        = string
}

# ==== Création de l'instance EC2 avec un nom UNIQUE ====

resource "aws_instance" "ec2_instance_${var.timestamp}" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "GitHubInstance-${var.timestamp}"
  }
}

# ==== Output pour récupérer l'ID de l'instance ====

output "instance_id" {
  value = aws_instance.ec2_instance_${var.timestamp}.id
}
