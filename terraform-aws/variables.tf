variable "acces_key" {
  description = "Acces key to AWS"
}
variable "secret_key" {
  description = "Secret key to AWS"
}
variable "region" {
  description = "Rigion"
  default     = "us-east-1"
}
variable "disk_image" {
  description = "Disk image"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
