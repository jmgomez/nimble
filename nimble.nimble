# Package

version       = "0.14.2"
author        = "Dominik Picheta"
description   = "Nim package manager."
license       = "BSD"

bin = @["nimble"]
srcDir = "src"
installExt = @["nim"]

# Dependencies

requires "nim >= 0.13.0"

when defined(nimdistros):
  import distros
  if detectOs(Ubuntu):
    foreignDep "libssl-dev"
  else:
    foreignDep "openssl"

before install:
  exec "nim r src/nimblepkg/private/clone.nim"

before build:
  exec "nim r src/nimblepkg/private/clone.nim"
