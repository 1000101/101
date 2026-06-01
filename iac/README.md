# IaaC example

This is a template example of automatic deployment through [Colmena](https://github.com/zhaofengli/colmena).

## How to

You can use [Colmena](https://github.com/zhaofengli/colmena) for the whole hive or machine by machine using `--on`.

If you are using nix / NixOS you can get into env with latest Colmena available simply by running:

```
nix develop
```

### Build

Building can be done locally or remotely, local build:

```
colmena build
# or host by host
colmena build --on "git.example.net"
```

### Deployment

```
colmena apply switch
# or host by host
colmena apply switch --on "git.example.net"

```
