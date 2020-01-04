resource "azurerm_virtual_network" "virtual_network" {
    name = "${var.name}-virtual-network"
    address_space = ["${var.cidr_block}"]
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"

    tags {
        environment = "${var.name}-environment"
    }
}

resource "azurerm_subnet" "subnet_1" {
    name = "${var.name}-subnet"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
    address_prefix = "${var.subnet_prefix}"

}

resource "azurerm_public_ip" "public_ip_1" {
    name = "${var.name}-public-ip-1"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    public_ip_address_allocation = "dynamic"

    tags {
        environment = "${var.name}-environment"
    }
}

resource "azurerm_public_ip" "public_ip_2" {
    name = "${var.name}-public-ip-2"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    public_ip_address_allocation = "dynamic"

    tags {
        environment = "${var.name}-environment"
    }
}

resource "azurerm_network_security_group" "network_security_group" {
    name = "${var.name}-network-security-group"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"

    security_rule {
        name = "SSH"
        priority = 1001
        direction = "inbound"
        access = "allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    tags {
        environment = "${var.name}-environment"
    }
}

resource "azurerm_network_interface" "network_interface_1" {
    name = "${var.name}-network-interface-1"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    network_security_group_id = "${azurerm_network_security_group.network_security_group.id}"

    ip_configuration {
        name = "${var.name}-nic-configuration"
        subnet_id = "${azurerm_subnet.subnet_1.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id = "${azurerm_public_ip.public_ip_1.id}"
    }

    tags {
        environment = "${var.name}-environment"
    }
}

resource "azurerm_network_interface" "network_interface_2" {
    name = "${var.name}-network-interface-2"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    network_security_group_id = "${azurerm_network_security_group.network_security_group.id}"

    ip_configuration {
        name = "${var.name}-nic-configuration"
        subnet_id = "${azurerm_subnet.subnet_1.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id = "${azurerm_public_ip.public_ip_2.id}"
    }

    tags {
        environment = "${var.name}-environment"
    }
}


