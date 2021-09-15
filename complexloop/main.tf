
locals {

  region = "eu"
  env    = "staging"
  region_env_mapping = {
    asia = ["dev", "qa", "staging", "demo", "prod"]
    eu   = ["staging", "demo"]
  }
  region_env_ids = {
    asia = {
      dev     = 5
      qa      = 6
      staging = 7
      demo    = 8
      prod    = 9
    }
    eu = {
      staging = 10
      demo    = 11
    }
  }
  service_name_list = [
    {
      id   = 1
      name = "productpage"
    },
    {
      id   = 2
      name = "details"
    },
    {
      id   = 3
      name = "reviews"
    },
    {
      id   = 4
      name = "ratings"
    }
  ]

  service_entries_tuple = flatten([for service in local.service_name_list : [
    [for ns_region, ns_env_group in local.region_env_mapping :
      {
        domain  = format("%s.%s", service.name, "global")
        env     = local.env
        region  = local.region
        address = format("240.0.%s.%s", local.region_env_ids[ns_region][local.env] ,service.id)
      }
      if local.region == ns_region && contains(ns_env_group, local.env)
    ]
  ]])

  virtual_services_global = flatten([for service in local.service_name_list :
    [for ns_region, ns_env_group in local.region_env_mapping :
      {
        name        = format("%s.%s", service.name, "global")
        host        = format("%s.%s", service.name, "global")
        destination = format("%s.%s.%s.%s", service.name, local.env, ns_region, "global")
      }
      if local.region == ns_region && contains(ns_env_group, local.env)
    ]
  ])

  virtual_services_region_global = flatten([for service in local.service_name_list :
    [for ns_region, ns_env_group in local.region_env_mapping :
      {
        name        = format("%s.%s.%s", service.name, ns_region, "global")
        host        = format("%s.%s.%s", service.name, ns_region, "global")
        destination = format("%s.%s.%s.%s", service.name, local.env, ns_region, "global")
      }
      if contains(ns_env_group, local.env)
    ]
  ])

  virtual_services = concat(local.virtual_services_global, local.virtual_services_region_global)
}