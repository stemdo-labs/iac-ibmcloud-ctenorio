output "generated_ssh_key_public" {
  value = {
    ssh_public_key = file("/tmp/generated_key.pub")
  }
  description = "Clave pública SSH generada dentro de la VM"
}
