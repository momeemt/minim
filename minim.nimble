# Package

version       = "0.1.0"
author        = "momeemt"
description   = "A new awesome nimble package"
license       = "Apache-2.0"
srcDir        = "src"
binDir        = "bin"
bin           = @["minim"]

# Dependencies

requires "nim >= 1.6.10"
requires "fusion == 1.2"
requires "cligen == 1.5.37"