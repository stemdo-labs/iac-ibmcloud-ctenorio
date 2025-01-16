variable "ibmcloud_api_key" {
  description = "API key"
  type        = string
  # default = "P88JqyM1gTLmrA0nFN0ATYpbZ2_sFjs25kQeyTdXsd0M"
}

variable "resource_group_id" {
  description = "Resource group ID"
  type        = string
 # default = "4364ced224cf420fa07d8bf70a8d70df"
}

variable "region" {
  description = "Region"
  type        = string
  default = "eu-es"
}

variable "zone" {
  description = "Zona"
  type        = string
    default = "eu-es-1"
}

variable "public_ssh_key" {
  description = "ssh key"
  type        = string
 # default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVVZumdywAEVakPmARPibYw10AebgXJHnbuB0LW5cGWe1vePvDF9QWA02raC89jtKhehnF6x+juafgPddtPZMDYmTVBS6k6zjW42QD1om1/dOCvJ1e62RIXqCCC28s9N5HN23o8ZlUEhcOWmvxgq8fr5BBk+o532BOpEbLCbtsYXf7K0PM+cOeMYis0A8wtqK6DLVdLM6u3bHnON7kbbm0qTmkSII69N+oanmRBa8ZUxBgI7Kzxn2GDuOmOvMdf1oLhg/R2jBL/0RsUXU/E2WzYZDwythYBEOj2w0xA/mE2rDhA6BgMvDCFXd7MrfBP6b3/U3y5nzTl4lEa5HtAjf9aKDMoR9R6pIgQxjnodvjtLZ0dGGabyfNpmxU5IkOwAUVKPsyqsMIXRDyMZ8uVg35EhMkWQ0P9TFA1JzC6QPa2s6igzFz3O3LCsGn5rOBesqiicq6jtGwR3iOs2fvjI6oDqh7nvFuDVQREV1veUcMaHiVmtIftIjsV6VdNDswq3NhLGSfRRu7f7eJEhnLqdBH6d3Zui7uZ52WSZP3suPQd+mnAl+Y0qkn2MzTdYnv1AAUlK7359URFZVamcvkgioc7pFscooatIiHcw7IYwpkos6Njf7rq4mUKIspBxUaN3V2YcZePGX5kFenT52+sWW2UTOd5Fkinkn3I1wtWWdNXw== user@stemdo"
}

variable "vpc_cluster_id" {
  description = "VPC cluster id"
  type        = string
  default = "r050-f896f857-9b61-49f4-821f-cd044dc361a0"
}



