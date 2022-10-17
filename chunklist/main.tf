locals {
  env_list = ["dev", "qa", "staging", "demo", "prod"]
  chunk = chunklist(local.env_list, 2)
}
