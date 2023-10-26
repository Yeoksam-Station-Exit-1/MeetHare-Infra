
# resource "kubernetes_secret_v1" "route53_credentials_secret" {
#   metadata {
#     name      = "route53-credentials-secret"
#     namespace = "istio-system"
#   }

#   data = {
#     access-key-id     = "AKIAYZIRV3TSXBNT5GQM"
#     secret-access-key = "mY4/w538Q900e0dBoPUV1yveH8aXGu/AhAaBDuLB1"
#   }

#   type = "Opaque"
# }

# resource "kubernetes_manifest" "letsencrypt_dns01_route53_issuer" {
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "ClusterIssuer"

#     metadata = {
#       name      = "letsencrypt-dns01-route53-issuer"
#       namespace = "istio-system"
#     }

#     spec : {
#       acme = {
#         server = "https://acme-v02.api.letsencrypt.org/directory"
#         email  = "ssafy0944430@gmail.com"

#         privateKeySecretRef = {
#           name = "letsencrypt-dns01-route53-key-pair"
#         }

#         solvers = [
#           {
#             selector = {
#               dnsZones = [
#                 "meethare.site"
#               ]
#             }
#             dns01 = {
#               route53 = {
#                 region = "ap-northeast-2"
#                 # hostedZoneID = "Z025..."

#                 accessKeyIDSecretRef = {
#                   name = kubernetes_secret_v1.route53_credentials_secret.metadata[0].name
#                   key  = "access-key-id"
#                 }
#                 secretAccessKeySecretRef = {
#                   name = kubernetes_secret_v1.route53_credentials_secret.metadata[0].name
#                   key  = "secret-access-key"
#                 }
#               }
#             }
#           }
#         ]
#       }
#     }
#   }
# }

# resource "kubernetes_manifest" "meethare_site_cert" {
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "Certificate"

#     metadata = {
#       name      = "meethare-site-cert"
#       namespace = "istio-system"
#     }

#     spec = {
#       secretName = "meethare-site-key-pair"
#       commonName = "meethare.site"

#       dnsNames = [
#         "meethare.site"
#       ]

#       duration    = "2160h0m0s" # 90 days
#       renewBefore = "360h0m0s" # 15 days

#       privateKey = {
#         algorithm = "RSA"
#         encoding  = "PKCS1"
#         size      = 4096
#       }

#       issuerRef = {
#         name  = "letsencrypt-dns01-route53-issuer"
#         kind  = "ClusterIssuer"
#         group = "cert-manager.io"
#       }
#     }
#   }
# }