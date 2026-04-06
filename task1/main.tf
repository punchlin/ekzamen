
# 1. VPC (Змінена назва для уникнення конфлікту)
resource "digitalocean_vpc" "vpc" {
  name     = "${var.surname}-vpc-new"
  region   = var.region
  ip_range = "10.10.20.0/24"
}

# 2. Firewall
resource "digitalocean_firewall" "firewall" {
  name = "${var.surname}-firewall"

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

# 3. VM (Droplet)
resource "digitalocean_droplet" "node" {
  name     = "${var.surname}-node"
  region   = var.region
  size     = "s-2vcpu-4gb"
  image    = "ubuntu-24-04-x64"
  vpc_uuid = digitalocean_vpc.vpc.id
}

# 4. Сховище (Bucket)
resource "digitalocean_spaces_bucket" "bucket" {
  name   = "${var.surname}-bucket-exam"
  region = var.region
}