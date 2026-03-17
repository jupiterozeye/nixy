# NVF is a Neovim configuration that provides a minimal setup with essential plugins and configurations.
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./options.nix
    ./languages.nix
    ./picker.nix
    ./snacks.nix
    ./keymaps.nix
    ./utils.nix
    ./mini.nix
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      lazy.enable = true;

      startPlugins = [
        pkgs.vimPlugins.vim-kitty-navigator
        pkgs.vimPlugins.nvim-cmp
      ];

      lazy.plugins = {
        "99" = {
          package = pkgs.vimUtils.buildVimPlugin {
            pname = "99";
            version = "2025-02-19";
            src = pkgs.fetchFromGitHub {
              owner = "ThePrimeagen";
              repo = "99";
              rev = "master";
              sha256 = "sha256-z8hafm8EWS7dXoDXnZ/1ddvtpWKVUtJfvQmWT4zXIdg=";
            };
            nvimSkipModules = [ "99.editor.lsp" ];
          };
          lazy = true;
          after = ''
            local _99 = require("99")

            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
              model = "opencode/kimi-k2.5-free",
              tmp_dir = "./tmp",
              logger = {
                level = _99.DEBUG,
                path = "/tmp/" .. basename .. ".99.debug",
                print_on_error = true,
              },
              completion = {
                custom_rules = {
                  "scratch/custom_rules/",
                },
                source = "cmp",
              },
              md_files = {
                "AGENT.md",
              },
            })
          '';
          keys = [
            {
              key = "<leader>9v";
              mode = "v";
              action = "<cmd>lua require('99').visual()<cr>";
            }
            {
              key = "<leader>9x";
              mode = "n";
              action = "<cmd>lua require('99').stop_all_requests()<cr>";
            }
            {
              key = "<leader>9s";
              mode = "n";
              action = "<cmd>lua require('99').search()<cr>";
            }
          ];
        };
      };
    };
  };
}
