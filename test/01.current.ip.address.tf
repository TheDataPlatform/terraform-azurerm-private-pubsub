provider "http" {}
data "http" "my_ip" {
  url = "https://ifconfig.me/ip"
}

locals {
    current_ip_address = trimspace(data.http.my_ip.response_body)
}