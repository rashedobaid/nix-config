{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    telegram
    viber
  ];
}
