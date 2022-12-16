terraform {
  source = ".//dummy"
}

locals {
  foobar = { "aaa" : "123" }
  kv     = merge(local.foobar, { "bbb" : "321" })
}

inputs = {
  ccc = local.kv
}
