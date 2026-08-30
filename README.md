# nix-config

This repository contains a flake-based Nix configuration for macOS and NixOS. It manages operating-system settings, packages, Homebrew applications, fonts, shell tools, and user dotfiles in one place.

The configuration currently defines two hosts:

- **`macbookpro`** — an Apple Silicon macOS system managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin)
- **`nixos`** — an x86_64 Linux system managed with NixOS (work in progress)

The user configuration for both hosts is managed with [Home Manager](https://github.com/nix-community/home-manager).

## Prerequisites

Install Nix with support for flakes and the `nix-command` experimental feature. This repository enables those features itself through `modules/common/nix-settings.nix`, but Nix must be installed before the flake can be evaluated.

You also need:

- Git
- `sudo` access when applying a system configuration
- On macOS, an existing or bootstrappable nix-darwin installation
- On NixOS, a working NixOS installation and configuration environment

Clone the repository and enter it:

```sh
git clone <repository-url> ~/.config/nix
cd ~/.config/nix
```

Replace `<repository-url>` with the URL of this repository.

## How the flake works

The entry point is [`flake.nix`](flake.nix). It pins three inputs:

- `nixpkgs` from the `nixpkgs-unstable` channel
- `nix-darwin` for macOS system configuration
- `home-manager` for user-level configuration

Both `nix-darwin` and Home Manager follow this flake's `nixpkgs` input, so the system and user packages are evaluated against the same pinned nixpkgs revision. The exact revisions are recorded in [`flake.lock`](flake.lock).

### Flake outputs

The flake exposes these system configurations:

```text
darwinConfigurations.macbookpro
nixosConfigurations.nixos
```

The name after `.#` in an apply command must match one of these output names.

### Automatic module loading

`flake.nix` defines an `importAll` helper. It reads each directory and imports every direct child whose filename ends in `.nix`.

For the macOS host, the following are combined:

1. Every module in `modules/common/`
2. Every module in `modules/darwin/`
3. Every module in `modules/darwin/lunaria/`
4. The Home Manager Darwin module and the user configuration

For the NixOS host, it combines:

1. Every module in `modules/common/`
2. Every module in `modules/nixos/`
3. The Home Manager NixOS module and the user configuration

Because modules are discovered automatically, adding a new `.nix` file to one of these directories generally makes it part of that host. Files in nested directories are not discovered unless the nested directory is explicitly included, as is the case for `modules/darwin/lunaria/`.

## Repository layout

```text
.
├── flake.nix                         # Inputs and host definitions
├── flake.lock                        # Locked input revisions
├── modules/
│   ├── common/                       # Shared settings, packages, and fonts
│   ├── darwin/                       # macOS defaults and host configuration
│   │   └── lunaria/                  # macOS host-specific settings
│   ├── dotfiles/                     # Home Manager modules and config files
│   └── nixos/                        # NixOS-specific settings and packages
├── users/
│   └── rashedobaid/                  # Home Manager user configuration
└── .github/workflows/
    └── update-flake-lock.yml         # Scheduled/manual lock-file updates
```

### Shared system configuration

`modules/common/` applies to both hosts:

- Enables flakes and `nix-command`
- Allows unfree packages
- Installs common command-line tools such as `btop`, `jq`, `neovim`, `ripgrep`, `tmux`, `tree`, `wget`, and `yq`
- Installs the JetBrains Mono Nerd Font

### macOS configuration

`modules/darwin/` and `modules/darwin/lunaria/` configure the Mac:

- Apple Silicon platform (`aarch64-darwin`)
- Primary user `rashedobaid`
- System and development packages, including Docker/Colima, cloud CLIs, Kubernetes/Terraform tooling, Zed, Raycast, and Rectangle
- Homebrew casks, brews, and Mac App Store applications
- Touch ID authentication for local `sudo`
- Finder, Dock, trackpad, keyboard repeat, screenshot, and Spotlight preferences
- A launch daemon that raises the macOS `maxfiles` limit
- A shell initialization limit of `2048` open files

Homebrew activation is configured to auto-update, upgrade installed entries, and uninstall entries not listed in the configuration. Review `modules/common/default.nix` before applying if you have manually installed Homebrew packages you want to keep.

### NixOS configuration (work in progress)

`modules/nixos/` contains the initial Linux host configuration:

- x86_64 Linux platform (`x86_64-linux`)
- User `rashedobaid` as a normal user with access to `wheel`
- Zsh as the user's login shell
- NixOS packages including Firefox, Telegram, and Viber

The NixOS module is still in progress and does not yet include the machine-specific hardware configuration required for a complete installation. Keep the generated hardware configuration for the target machine and import it from the NixOS host configuration when this host is completed.

### Home Manager and dotfiles

[`users/rashedobaid/default.nix`](users/rashedobaid/default.nix) is imported by both hosts. It sets the Home Manager username and state version, then imports:

- [`modules/dotfiles/zsh/`](modules/dotfiles/zsh/) — Zsh, completion, autosuggestions, syntax highlighting, Powerlevel10k, fzf, direnv, zoxide, aliases, and shell initialization
- [`modules/dotfiles/ghostty/`](modules/dotfiles/ghostty/) — Ghostty settings using the TokyoNight Night theme and JetBrains Mono
- [`modules/dotfiles/fastfetch/`](modules/dotfiles/fastfetch/) — fastfetch and its config file
- [`modules/dotfiles/linearmouse/`](modules/dotfiles/linearmouse/) — LinearMouse configuration
- [`users/rashedobaid/gitconfig.nix`](users/rashedobaid/gitconfig.nix) — Git identity and automatic remote setup on first push

The `deploy-nix` Zsh alias is also defined by the Zsh module. From a flake directory, it updates the lock file if it has not changed in the last hour and runs a macOS rebuild. Its equivalent is:

```sh
nix flake update
sudo darwin-rebuild switch --flake .#macbookpro
```

The alias is macOS-specific; use the NixOS command below on Linux.

## Applying the configuration

Run commands from the repository root.

### macOS

For an already-installed nix-darwin setup:

```sh
sudo darwin-rebuild switch --flake .#macbookpro
```

This evaluates the `macbookpro` output, activates the system configuration, updates Homebrew according to the declarations, and activates the Home Manager user configuration.

On a first nix-darwin installation, bootstrap nix-darwin using its documented installer/bootstrap process, then run the command above. The exact bootstrap command can vary with the Nix installation method and nix-darwin version.

### NixOS

Apply the Linux host configuration with:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

If the repository is outside the current directory, use an absolute path:

```sh
sudo nixos-rebuild switch --flake ~/.config/nix#nixos
```

The same flake can also be used to test or build without switching:

```sh
sudo nixos-rebuild test --flake .#nixos
sudo nixos-rebuild build --flake .#nixos
```

`test` activates the configuration without making it the boot default. `build` only builds the result.

## Updating inputs

Update all flake inputs and rewrite [`flake.lock`](flake.lock) with:

```sh
nix flake update
```

Then inspect and apply the result:

```sh
nix flake check
sudo darwin-rebuild switch --flake .#macbookpro
# or:
sudo nixos-rebuild switch --flake .#nixos
```

The GitHub Actions workflow in [`.github/workflows/update-flake-lock.yml`](.github/workflows/update-flake-lock.yml) runs daily at 03:00 UTC and can also be started manually. It installs Nix, runs `nix flake update`, commits changes to `flake.lock`, and pushes them to `main`.

Because this uses `nixpkgs-unstable`, updates can introduce changes or breakages. Review lock-file update commits before applying them to a machine.

## Rollback

If a new configuration causes problems, list available generations and switch to a previous one using the platform's normal generation tooling.

On macOS:

```sh
darwin-rebuild --list-generations
sudo darwin-rebuild switch --rollback
```

On NixOS:

```sh
sudo nixos-rebuild switch --rollback
```

You can also apply a known-good Git revision of this repository by checking it out (or using a separate worktree) and running the appropriate rebuild command again.

## State-version note

The macOS module uses nix-darwin's numeric `system.stateVersion`, while the in-progress NixOS module uses a release string (`"25.11"`). These values are compatibility declarations; change them deliberately when following the relevant nix-darwin or NixOS upgrade guidance.

## Validation and useful commands

Evaluate the flake and run its checks:

```sh
nix flake check
```

The macOS output currently evaluates successfully. The full check still reports the expected missing root filesystem and boot-loader settings for the in-progress NixOS output.

Inspect the available outputs:

```sh
nix flake show
```

Format Nix files with the formatter installed by this configuration:

```sh
nixfmt <file.nix>
```

Before applying changes, review the generated configuration and ensure the target name is correct:

```sh
nix flake show
```

Do not commit secrets. The repository ignores `/secrets`, `.direnv`, macOS metadata, and common temporary files, but secrets should still be handled through an appropriate external secret-management solution.

## Important conventions

- Keep host-specific settings in `modules/darwin/`, `modules/darwin/lunaria/`, or `modules/nixos/`.
- Put settings shared by both operating systems in `modules/common/` only when they are valid on both platforms.
- Put user-level programs and dotfiles in Home Manager modules under `modules/dotfiles/` or `users/rashedobaid/`.
- New directly imported modules must have a `.nix` extension.
- Check the target architecture before reusing a host module: the Mac configuration targets `aarch64-darwin`, while the NixOS configuration targets `x86_64-linux`.
- Remember that `system.stateVersion` and Home Manager's `home.stateVersion` are compatibility declarations. Change them deliberately rather than treating them as a routine upgrade setting.
