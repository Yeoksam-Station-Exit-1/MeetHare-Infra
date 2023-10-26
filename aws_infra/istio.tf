# locals {
#   istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
# }

# resource "helm_release" "istio-base" {
#   repository       = local.istio_charts_url
#   chart            = "base"
#   name             = "istio-base"
#   namespace        = var.istio-namespace
#   # version          = "1.15.3"
#   version          = "1.17.1"
#   create_namespace = true
#   depends_on = [module.eks]
# }

# resource "helm_release" "istiod" {
#   repository       = local.istio_charts_url
#   chart            = "istiod"
#   name             = "istiod"
#   namespace        = var.istio-namespace
#   create_namespace = true
#   version          = "1.17.1"
#   depends_on       = [helm_release.istio-base]
# }

# # resource "kubernetes_namespace" "istio-ingress" {
# #   metadata {
# #     labels = {
# #       istio-injection = "enabled"
# #     }

# #     name = "istio-ingress"
# #   }
# #   depends_on = [module.eks]
# # }

# # resource "helm_release" "istio-ingress" {
# #   repository = local.istio_charts_url
# #   chart      = "gateway"
# #   name       = "istio-ingress"
# #   namespace  = var.istio-namespace
# #   version          = "1.17.1"
# #   create_namespace = true
# #   depends_on = [helm_release.metrics_server, helm_release.istio-base, helm_release.istiod]

# #   set {
# #     name  = "service.type"
# #     value = "NodePort"
# #   }

# #   set {
# #     name  = "autoscaling.minReplicas"
# #     value = var.istio_ingress_min_pods
# #   }

# #   set {
# #     name  = "autoscaling.maxReplicas"
# #     value = var.istio_ingress_max_pods
# #   }

# #   set {
# #     name  = "service.ports[0].name"
# #     value = "status-port"
# #   }

# #   set {
# #     name  = "service.ports[0].port"
# #     value = 15021
# #   }

# #   set {
# #     name  = "service.ports[0].targetPort"
# #     value = 15021
# #   }

# #   set {
# #     name  = "service.ports[0].nodePort"
# #     value = 30021
# #   }

# #   set {
# #     name  = "service.ports[0].protocol"
# #     value = "TCP"
# #   }

# #   set {
# #     name  = "service.ports[1].name"
# #     value = "http2"
# #   }

# #   set {
# #     name  = "service.ports[1].port"
# #     value = 80
# #   }

# #   set {
# #     name  = "service.ports[1].targetPort"
# #     value = 80
# #   }

# #   set {
# #     name  = "service.ports[1].nodePort"
# #     value = 30080
# #   }

# #   set {
# #     name  = "service.ports[1].protocol"
# #     value = "TCP"
# #   }


# #   set {
# #     name  = "service.ports[2].name"
# #     value = "https"
# #   }

# #   set {
# #     name  = "service.ports[2].port"
# #     value = 443
# #   }

# #   set {
# #     name  = "service.ports[2].targetPort"
# #     value = 443
# #   }

# #   set {
# #     name  = "service.ports[2].nodePort"
# #     value = 30443
# #   }

# #   set {
# #     name  = "service.ports[2].protocol"
# #     value = "TCP"
# #   }
# # }