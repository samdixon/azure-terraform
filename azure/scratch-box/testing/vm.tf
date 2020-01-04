resource "azurerm_virtual_machine" "myTerraformVM" {
    name = "myVM"
    location = "eastus"
    resource_group_name = "${azurerm_resource_group.terraformTest.name}"
    network_interface_ids = ["${azurerm_network_interface.terraformTestNic.id}"]
    vm_size = "Standard_DS1_v2"

    storage_os_disk {
        name = "osDick"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "myvm"
        admin_username = "azureuser"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0niKUKFoPdcwKVFCzBVm/PcXRNYpitX3IOw86BZ8j1YX0e29DnSN+8PNIWX9B1Un4CQqx7D/Rbk779TL7X959zDvReOpjSbpEKU84X7UbMzhQTlzQk9iSnMqBe1JIE+zkfvH+izdkEpaWIXkmT0kDWRGHtj/WaLx72rgysH+/lDg1tHus4mIKmdIlQpyfvXlHVhLiFnpy6HdNqcu/sSdMwvcBwLtJyvq137K60tCyf9Nw4gTPn2gtpVUyFzDJ6Z4l01P9s7sOiOBVoVukhN/BruvnfXKpNohXB04fpwhaK3rwxKnhgGawaAuuAnXJEQMroDSaLfkHU+qKsyzGmdtf sdixon@Sams-MacBook-Pro.local"
        }
    }

    boot_diagnostics {
        enabled     = "true"
        storage_uri = "${azurerm_storage_account.myStorageAccount.primary_blob_endpoint}"
    }

    tags {
        environment = "Terraform Demo"
    }

}
