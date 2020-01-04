resource "digitalocean_project" "sjdsh_project" {
  name = var.sjdsh_domain
  description = var.sjdsh_description
  environment = var.defaults_prodenv
  resources = [digitalocean_domain.sjdsh_domain.urn]
}

resource "digitalocean_domain" "sjdsh_domain" {
  name = var.sjdsh_domain
}

