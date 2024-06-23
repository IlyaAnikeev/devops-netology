locals {
    ssh-keys         = file("~/.ssh/id_ed25519.pub")
    ssh-private-keys = file("~/.ssh/id_ed25519")
  }