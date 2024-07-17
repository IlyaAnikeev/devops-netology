resource "yandex_alb_http_router" "http-router" {
  name                    = var.alb_http_router_name
  labels                  = {
    tf-label              = var.alb_http_router_tf_lable
    empty-label           = var.alb_http_router_empty-label
  }
}

resource "yandex_alb_virtual_host" "virtual-host" {
  name                    = var.alb_virtual_host_name
  http_router_id          = yandex_alb_http_router.http-router.id
  route {
    name                  = var.alb_virtual_host_route_name
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.backend-group.id
        timeout           = var.alb_virtual_host_route_timeout
      }
    }
  }
  
  depends_on              = [yandex_alb_backend_group.backend-group]
}