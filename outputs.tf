output "vpc_id" {
  value = module.vpc.vpc_id
}

output "workspace" {
  value = "THE CURRENT WORKSPACE IS ${terraform.workspace}"
}