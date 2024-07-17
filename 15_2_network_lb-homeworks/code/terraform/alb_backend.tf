resource "yandex_alb_backend_group" "backend-group" {
  name                     = var.alb_backend_name
  session_affinity {
    connection {
      source_ip            = var.alb_backend_source_ip
    }
  }

  http_backend {
    name                   = var.alb_http_backend_name
    weight                 = var.alb_http_backend_weight
    port                   = var.alb_http_backend_port
    target_group_ids       = [yandex_alb_target_group.alb-tg.id]
    load_balancing_config {
      panic_threshold      = var.alb_http_backend_panic_threshold
    }    
    healthcheck {
      timeout              = var.alb_http_backend_healthcheck_timeout
      interval             = var.alb_http_backend_healthcheck_interval
      healthy_threshold    = var.alb_http_backend_healthcheck_healthy_threshold
      unhealthy_threshold  = var.alb_http_backend_healthcheck_unhealthy_threshold
      http_healthcheck {
        path               = var.alb_http_backend_healthcheck_path
      }
    }
  }

  depends_on               = [yandex_alb_target_group.alb-tg]
}