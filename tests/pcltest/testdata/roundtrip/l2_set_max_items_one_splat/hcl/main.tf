terraform {
  required_providers {
    blocky = {
      source  = "pulumi/blocky"
      version = "0.0.1"
    }
  }
}

# `opt` is a TypeSet MaxItems=1 block. The bridge flattens it to one object,
# but HCL reads a set, which HCL cannot index. A splat over the ranged
# resource reads the block of each instance.
resource "blocky_single" "set" {
  count = 2
  pulumi {
    name ="set-${count.index}"
  }
  lifecycle {
    create_before_destroy = true
  }
  opt {
    label = "b"
  }
}
output "labels" {
  value = [for v in blocky_single.set : one(v.opt).label]
}
