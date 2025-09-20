{ pkgs, ... }: {
  system.primaryUser = "rashedobaid";
  nixpkgs.hostPlatform = "aarch64-darwin";
}
