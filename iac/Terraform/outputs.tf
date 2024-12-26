output "generated_ssh_key_public" {
  value       = ibm_is_instance.vm_db.primary_network_interface[0].id
  description = "Clave pública SSH generada dentro de la VM."
}
