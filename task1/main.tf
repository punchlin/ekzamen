# 1. Віртуальна приватна хмара (VPC)
resource "digitalocean_vpc" "vpc" {
  name     = "${var.surname}-vpc"
  region   = var.region
  ip_range = "10.10.10.0/24"
}

# 2. Налаштування фаєрволу
resource "digitalocean_firewall" "firewall" {
  name = "${var.surname}-firewall"

  # Вхідні (inbound) порти: 22, 80, 443, 8000-8003
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "8000-8003"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Вихідні (outbound) порти: 1-65535
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  droplet_ids = [digitalocean_droplet.node.id]
}

# 3. ВМ (Droplet) для Minikube (Ubuntu 24, 2vCPU, 4GB RAM)
resource "digitalocean_droplet" "node" {
  name     = "${var.surname}-node"
  region   = var.region
  size     = "s-2vcpu-4gb" # Відповідає вимогам Minikube
  image    = "ubuntu-24-04-x64"
  vpc_uuid = digitalocean_vpc.vpc.id
}

# 4. Сховище (Bucket)
resource "digitalocean_spaces_bucket" "bucket" {
  name   = "${var.surname}-bucket"
  region = var.region
}