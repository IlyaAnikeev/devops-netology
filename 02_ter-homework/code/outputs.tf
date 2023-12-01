output "external_ip" {
    value = {
        instance_name_vm1 = yandex_compute_instance.platform.name
        external_ip_vm1 = yandex_compute_instance.platform.network_interface.0.nat_ip_address
        instance_name_vm2 = yandex_compute_instance.platform_2.name
        external_ip_vm2 = yandex_compute_instance.platform_2.network_interface.0.nat_ip_address
    }
}

output "admin" { 
    value = "${local.test_map.admin} is admin for ${local.test_list[length(local.test_list)-1]} server based on OS ${local.servers[local.test_list[length(local.test_list)-1]]["image"]} with ${local.servers[local.test_list[length(local.test_list)-1]]["cpu"]} vcpu, ${local.servers[local.test_list[length(local.test_list)-1]]["ram"]} ram, and ${local.servers.production["disks"][0]}, ${local.servers.production["disks"][1]}, ${local.servers.production["disks"][2]}, ${local.servers.production["disks"][3]} virtual disks." 
    }
  