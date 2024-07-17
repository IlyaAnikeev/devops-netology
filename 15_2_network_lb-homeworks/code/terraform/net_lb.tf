resource "yandex_lb_network_load_balancer" "net_lb" {
  name                    = var.net_lb_name
  deletion_protection     = var.net_lb_deletion_protection
  listener {
    name                  = var.net_lb_listener_name
    port                  = var.net_lb_listener_port
    external_address_spec {
      ip_version          = var.net_lb_listener_ip_version
    }
  }
  attached_target_group {
    target_group_id       = yandex_compute_instance_group.group_vm.load_balancer[0].target_group_id
    healthcheck {
      name                = var.net_lb_healthcheck_name
      interval            = var.net_lb_healthcheck_interval
      timeout             = var.net_lb_healthcheck_timeout
      unhealthy_threshold = var.net_lb_healthcheck_unhealthy_threshold
      healthy_threshold   = var.net_lb_healthcheck_healthy_threshold
      http_options {
        port              = var.net_lb_healthcheck_port
        path              = var.net_lb_healthcheck_path
      }
    }
  }
}