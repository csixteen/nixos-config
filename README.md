# NixOS configuration for Framework 13 AMD

My NixOS configuration for a recently purchased Framework 13 AMD laptop. Under [framework](./framework) you'll find the system configuration, whereas under [home-manager](./home-manager) is my regular user's config. I did a [standalone installation](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) for Home Manager.

I finally found a good excuse to learn Nix / NixOS. It took me roughly 2 days to go from zero to a fully working environment, mostly because documentation online is pretty decent. A few sources of inspiration:
- https://github.com/NixOS/nixos-hardware
- https://github.com/gkapfham/nixos

Having said that, I'm still learning and some of the configuration here will change over time.

# Specs

## Hardware
- Framework 13 AMD Ryzen 5 7640U / Radeon 760M Graphics
- 64GB RAM
- 1TB SSD

## Software

I'm running i3wm with no desktop manager. I've tried using i3 with Xfce as a [desktop manager](https://nixos.wiki/wiki/Xfce#Using_as_a_desktop_manager_and_not_a_window_manager), but for whatever reason it discarded my `logind` settings and the battery was draining quite fast with the lid closed. The main drawback of running i3 without a desktop manager is that it requires setting up `acpid` events and actions for controlling brightness, and also extra key bindings for controlling the volume.
