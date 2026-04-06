terraform {
  backend "s3" {
    endpoint                    = "fra1.digitaloceanspaces.com"
    region                      = "us-east-1" # Залишаємо так для сумісності
    bucket                      = "duplina-terraform-state" # ТВОЯ НАЗВА БАКЕТА
    key                         = "terraform.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}