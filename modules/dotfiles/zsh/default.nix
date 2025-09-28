{ config, pkgs, lib, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "ls --color";
        la = "ls --color -lha";
        df = "df -h";
        du = "du -ch";
        ipp = "curl ipinfo.io/ip";
        aspm = "sudo lspci -vv | awk '/ASPM/{print $0}' RS= | grep --color -P '(^[a-z0-9:.]+|ASPM )'";
        mkdir = "mkdir -p";
        colimastart = "colima start --arch aarch64 --vm-type vz --vz-rosetta --cpu 6 --memory 8 --disk 32";
        ibrew = "arch -x86_64 /usr/local/bin/brew";
        deploy-nix = "sudo darwin-rebuild switch --flake ~/.config/nix#macbookpro";
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
          file = "share/zsh-completions/zsh-completions.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ../powerlevel10k;
          file = "p10k.zsh";
        }
      ];

      initContent = ''
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' menu yes=long select
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        bindkey -e
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
        bindkey '^[[Z' reverse-menu-complete

        # OpenJDK 8
        export JAVA_HOME="/usr/local/opt/openjdk@8/libexec/openjdk.jdk/Contents/Home"
      '';
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
