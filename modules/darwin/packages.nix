{ pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      spotify = prev.spotify.overrideAttrs (old: {
        src = prev.fetchurl {
          url = "https://download.scdn.co/SpotifyARM64.dmg";
          sha256 = "1n78knawyk7alm11xryzqr1hdj33k52drxh4dnbg8xr17sap1rrb";
        };
      });
    })
  ];
  environment.systemPackages = with pkgs; [
    alt-tab-macos
    betterdisplay
    colima
    raycast
    rectangle
    utm
  ];
}
