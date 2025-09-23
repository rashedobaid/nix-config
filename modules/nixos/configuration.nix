{ pkgs, ... }: {
  system.primaryUser = "rashedobaid";
  nixpkgs.hostPlatform = "x86_64-linux";

  users.users.rashedobaid = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}
