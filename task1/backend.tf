terraform {
  backend "s3" {
    endpoint                    = "https://fra1.digitaloceanspaces.com" 
    region                      = "us-east-1" # Це залишаємо як є
    bucket                      = "duplina-terraform-state" # ПЕРЕВІР, ЧИ ТАКА НАЗВА В ТЕБЕ В DO!
    key                         = "terraform.tfstate"
    
    # Ці три рядки критично важливі для DigitalOcean:
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true # ЦЕ ВИПРАВИТЬ ГОЛОВНУ ПОМИЛКУ (STS/IAM)
  }
}