# Intro

# Table of content

# Architecture

[comment]: <> (Diagram)

[comment]: <> (2 Pis for Kubernetes cluster - cluster contains stateless applications, third pi used for Database, cloud instance &#40;stateful applications&#41;)

# Hardware

### Raspberry PI

[comment]: <> (Brand, specs, number of pis)

### HDD Storage

[comment]: <> (External HDD mounted as a disk to the stateful appplication pi with the sharing enabled to the other two PIs)

### Ethernet switch

TP-Link Easy Smart TL-SG105E Switch 5-porte G

[comment]: <> (Brand, specs, capacity, price)

### WiFi Router

TP-Link TL-MR6400 4G LTE Router

[comment]: <> (Brand, specs, price type - SIM)

### Power supply

Anker PowerPort 63

[comment]: <> (It was possible to use POE technology &#40;Power Over Ethernet&#41; - didn't use due to the hats being expensive)

[comment]: <> (Into to why good power supply is important, brand, specs, price)

### Cables

[comment]: <> (List - Types, price length? )

### Cluster rack

[comment]: <> (Rack with cooling + added heat sinks on the PI chip - where to buy + price - aliexpress has rack usually without fans)

# Software

### K3s Kubernetes distribution

[K3S Official Website](https://rancher.com/docs/k3s/latest/en/)

Bundles following technologies to single distribution:

* [Containerd](https://containerd.io/) & [runc](https://github.com/opencontainers/runc)
* [Flannel](https://github.com/coreos/flannel) for CNI
* [CoreDNS](https://coredns.io/)
* [Metrics Server](https://github.com/kubernetes-sigs/metrics-server)
* [Traefik](https://containo.us/traefik/) for ingress
* [Klipper-lb](https://github.com/k3s-io/klipper-lb) as an embedded service load balancer provider
* [Kube-router](https://www.kube-router.io/) netpol controller for network policy
* [Helm-controller](https://github.com/k3s-io/helm-controller) to allow for CRD-driven deployment of helm manifests
* [Kine](https://github.com/k3s-io/kine) as a datastore shim that allows etcd to be replaced with other databases
* [Local-path-provisioner](https://github.com/rancher/local-path-provisioner) for provisioning volumes using local
  storage
* [Host utilities](https://github.com/k3s-io/k3s-root) such as iptables/nftables, ebtables, ethtool, & socat

[comment]: <> (Had other possibilities, but have chosen to use this distribution due to: easy installation, documentation and a lot of support )

[comment]: <> (What is, link, pros )

### Ansible

[comment]: <> (What was used for, link to repo with Ansible settings)

### Terraform

[comment]: <> (Url to the project with Terraform, what was used for, reusable modules, state locking, state store - Terraform Cloud)

[comment]: <> (Code example with the full-deployment module - what resources are created when deployed?)

```
module "lil_linko_deployment" {
    source            = "../reusable-modules/full-deployment"
    health_check_path = "/healthcheck"
    image_tag         = "17"
    image_url         = "docker.io/tomondre/lil-linko"
    service_name      = local.lil_linko_host
    port              = 8080
    env               = {
        DATABASE_URL     = var.lil_linko_db_url
        HOST_URL         = "https://${local.lil_linko_host}.tomondre.com"
        ABSTRACT_API_KEY = var.lil_linko_abstract_api_key
    }
}
```

#### Resources created

1. Kubernetes Deployment
2. Kubernetes Service
3. Cloudflare DNS record
4. Treafik Ingrss Route for the DNS record

### Traefik

[comment]: <> (Reverse proxy that proxies traffic to the correct kubernetes services based on the host header value of the request. This is the only endpoint exposed to the network - on ports 80 and 443 )

### K9S Dashboard

[comment]: <> (Intro to the tool, Observability, very powerful tool to see all resource within the cluster)

### CloudFlared

[comment]: <> (Problem CG NAT, solution, security, what technology is used, how is it connected to the Cloudfare network - long polling)

### MariaDB

[comment]: <> (Why has been chosen, connectivity - overall very good for the PIs)

# Deployments

[comment]: <> (Link to the page with all the deployments)

[comment]: <> (- [Deployments]&#40;https://deployments.tomondre.com&#41;)

# Setup steps

[comment]: <> (https://www.youtube.com/watch?v=X9fSMGkjtug&t=1137s)

# References

* https://im.cyberport.de/is/image/cyberport/151216092328900701900054D?$Zoom_1000$
* https://static.tp-link.com/TL-SG105E_UN_4.0_01_normal_1517903567595c.jpg
* https://i0.wp.com/raw.githubusercontent.com/traefik/traefik/master/docs/content/assets/img/traefik-architecture.png?w=810&ssl=1
* 