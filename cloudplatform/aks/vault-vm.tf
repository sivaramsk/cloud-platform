

resource "azurerm_virtual_network" "main" {
  name                = format("%s-network", var.prefix)
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "internal" {
  name                 = format("%s-subnet", var.prefix)
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "default" {
    name                         = format("%s-ip", var.prefix)
    location                     = var.location
    resource_group_name          = var.resource_group
    allocation_method            = "Dynamic"
    domain_name_label            = var.prefix
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "default" {
    name                = format("%s-nsg", var.prefix)
    location            = var.location
    resource_group_name = var.resource_group

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "Vault"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8200"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_network_interface" "main" {
  name                = format("%s-nic", var.prefix)
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = format("%s-conf", var.prefix)
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.default.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "default" {
    network_interface_id      = azurerm_network_interface.main.id
    network_security_group_id = azurerm_network_security_group.default.id
}


resource "azurerm_linux_virtual_machine" "main" {
  name                  = format("%s-vm", var.prefix)
  location              = var.location
  resource_group_name   = var.resource_group
  size                  = var.vault_vmsize
  network_interface_ids = [azurerm_network_interface.main.id]
  admin_username        = "vaultadmin"
  
  admin_ssh_key {
    username = "vaultadmin"
    public_key = file("~/.ssh/id_rsa.pub")
  }  

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  
  os_disk {
    name              = format("%s-disk", var.prefix)
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

resource "azurerm_managed_disk" "default" {
  name                 = format("%s-disk1", var.prefix)
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 5
}

resource "azurerm_virtual_machine_data_disk_attachment" "default" {
  managed_disk_id    = azurerm_managed_disk.default.id
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = "10"
  caching            = "ReadWrite"
}
