resource "random_password" "foobar_secret" {
  length = 32
  special = false
}

// resource "tls_cert_request" "example" {
//   key_algorithm   = "ECDSA"
//   private_key_pem = "${file("private_key.pem")}"
// 
//   subject {
//     common_name  = "example.com"
//     organization = "ACME Examples, Inc"
//   }
// }
