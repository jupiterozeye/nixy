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
      startPlugins = [
        pkgs.vimPlugins.vim-kitty-navigator
        pkgs.vimPlugins.nvim-cmp
        (pkgs.vimUtils.buildVimPlugin {
          pname = "99";
          version = "2025-01-01";
          src = pkgs.fetchFromGitHub {
            owner = "ThePrimeagen";
            repo = "99";
            rev = "master";
            sha256 = "sha256-GxbYWoyULCbTw+3tKZ32br0NlywIajIq5fSc4Oy7YFo=";
          };
          nvimSkipModules = [ "99.editor.lsp" ];
        })
      ];

      luaConfigRC."99" = ''
        local _99 = require("99")

        local cwd = vim.uv.cwd()
        local basename = vim.fs.basename(cwd)
        _99.setup({
          model = "gpt-4o",
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

        vim.keymap.set("n", "<leader>9f", function()
          _99.fill_in_function()
        end)
        vim.keymap.set("v", "<leader>9v", function()
          _99.visual()
        end)
        vim.keymap.set("v", "<leader>9s", function()
          _99.stop_all_requests()
        end)
        vim.keymap.set("n", "<leader>9fd", function()
          _99.fill_in_function()
        end)
      '';
    };
  };
}
