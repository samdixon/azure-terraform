resource "digitalocean_project" "samdixonio_project" {
    name = var.samdixonio_domain
    description = var.samdixonio_description
    environment = var.defaults_prodenv
    resources = [digitalocean_domain.samdixonio_domain.urn]
}

resource "digitalocean_domain" "samdixonio_domain" { 
    name = var.samdixonio_domain
}

resource "digitalocean_record" "vesper" {
  domain = digitalocean_domain.samdixonio_domain.name
  type = "A"
  name = "vesper"
  value = var.samdixonio_vesper_ip
  ttl = var.defaults_ttl
}
