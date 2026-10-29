# `opt` is a TypeSet MaxItems=1 block. The bridge flattens it to one object,
# but HCL reads a set, which HCL cannot index. A splat over the ranged
# resource reads the block of each instance.
resource "set" "blocky:index/single:Single" {
  opt = {
    label = "b"
  }
  options {
    range = 2
  }
}

output "labels" {
  value = [for v in set : singleOrNone((v.opt == null ? [] : [v.opt])).label]
}

