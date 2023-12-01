
data "azurerm_subnet" "sub-agent" {
  name                 = "sub-agent"  
  virtual_network_name = var.vnet_prd_name
  resource_group_name  = var.resource_group_name   
  depends_on = [azurerm_subnet.sub-agent]
}
### ------------------------- Create an Azure Bastion VM
resource "azurerm_linux_virtual_machine" "vm-agent" {
  name                  = "vm-agent"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_agent_nic.id]
  size                  = "Standard_B2ms"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  admin_username                  = "seddinesq"
  admin_password                  = "Vmaccess**"
  disable_password_authentication = false
   depends_on = [azurerm_subnet.sub-agent]
}
# Network interface for the Bastion-vm
resource "azurerm_network_interface" "vm_agent_nic" {
  name                = "agent-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "agent-ipconfig"
    subnet_id = data.azurerm_subnet.sub-agent.id
    private_ip_address_allocation = "Dynamic"
  }
 
}
