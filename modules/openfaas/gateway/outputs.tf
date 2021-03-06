output "name" {
  value = module.deployment-service.name
}

output "service" {
  value = module.deployment-service.service
}

output "deployment" {
  value = module.deployment-service.deployment
}

output "service_account_name" {
  value = module.rbac.name
}
