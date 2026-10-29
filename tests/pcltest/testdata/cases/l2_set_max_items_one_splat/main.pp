# `opt` is a TypeSet MaxItems=1 block. The bridge flattens it to one object,
# but HCL reads a set, which HCL cannot index. A splat over the ranged
# resource reads the block of each instance.
resource "set" "blocky:index/single:Single" {
  options {
    range = 2
  }
  opt = {
    label = "b"
  }
}

output "labels" {
  value = set[*].opt.label
}
