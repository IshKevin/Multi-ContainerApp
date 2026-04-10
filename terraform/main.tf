terraform {
  required_version = ">= 1.5.0"
  
  # backend
#   backend "s3" {
#     bucket         = "multicontainerlab-state-854fb003"
#     key            = "state/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-lock"
#   }
}


module "compute" {
  source = "./modules/ec2"

  project_name  = var.project_name
  instance_type = var.instance_type
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tftpl", {
    ip_address = module.compute.public_ip,
    key_path   = "../terraform/${module.compute.key_name}.pem"
  })

  filename = "../ansible/inventory.ini"
}