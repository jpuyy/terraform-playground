output "random_password" {
  value = base64encode(random_password.foobar_secret.result)
  sensitive = true
}