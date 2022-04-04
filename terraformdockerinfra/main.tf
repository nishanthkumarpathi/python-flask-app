terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}
provider "docker" {}
resource "docker_image" "targetserver" {
  name         = "nishanthkp/targetserver:ubuntu16"
  keep_locally = true
}
resource "docker_container" "web_server" {
  image = docker_image.targetserver.name # Calling Line 12
  name  = "web_server"
  ports {
    internal = 5000
    external = 5000
  }
}
resource "docker_container" "db_server" {
  image = docker_image.targetserver.name # Caling line 12
  name  = "db_server"
  ports {
    internal = 3306
    external = 3306
  }
}