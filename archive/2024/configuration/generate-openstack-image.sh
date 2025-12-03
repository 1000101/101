#!/usr/bin/env bash
nix run nixpkgs#nixos-generators -- -c configuration.nix -f openstack
