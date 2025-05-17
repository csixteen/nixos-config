{ config, lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;

    extraPackages = [ pkgs.marksman ];

    settings = {
      theme = "ayu_mirage_custom";

      editor = {
        bufferline = "multiple";
        line-number = "relative";
        rulers = [100 120];
        true-color = true;
        color-modes = true;
        popup-border = "all";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
          max-depth = 8;
        };

        lsp = {
          display-inlay-hints = true;
          display-messages = true;
          display-signature-help-docs = true;
        };

        statusline = {
          center = ["version-control"];
          right = ["diagnostics" "selections" "position" "position-percentage" "file-encoding"];
        };
      };

      keys = {
        normal = {
          C-s = ":w";
          "esc" = ["keep_primary_selection" "collapse_selection"];

          "]" = {
            "]" = "goto_next_paragraph";
          };

          "[" = {
            "[" = "goto_prev_paragraph";
          };
        };
      };
    };

    languages = {
      language = [
        { name = "nix"; auto-format = true; formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt"; }
        { name = "rust"; auto-format = true; }
        { name = "haskell"; roots = ["*.cabal" "stack.yaml" "cabal.project" "package.yaml" "hie.yaml" ]; auto-format = true; }
        { name = "racket"; auto-format = true; }
      ];

      language-server.rust-analyzer.config = {
        check.command = "clippy";
        hover.actions.references.enable = true;
        hover.memoryLayout.niches = true;
        inlayHints.closingBraceHints.minLines = 10;
        inlayHints.closureCaptureHints.enable = true;
        inlayHints.closureReturnTypeHints.enable = "with_block";
        inlayHints.discriminantHints.enable = "always";
        inlayHints.lifetimeElisionHints.enable = "skip_trivial";
        inlayHints.typeHints.hideClosureInitialization = false;
        lens.references.adt.enable = true;
        lens.references.enumVariant.enable = true;
        lens.references.method.enable = true;
        lens.references.trait.enable = true;
        typing.autoClosingAngleBrackets.enable = true;
      };

      language-server.haskell-language-server = {
        command = "haskell-language-server-wrapper";
        args = ["--lsp"];

        config.haskell = {
          checkParents = "CheckOnSave";
          checkProject = true;
          formattingProvider = "ormolu";
          serverPath = "haskell-language-server-wrapper";
        };
      };
    };

    themes = {
      ayu_mirage_custom = {
        inherits = "ayu_mirage";

        "comment" = { fg = "#7f7f75"; };
        "ui.virtual.inlay-hint" = { fg = "#8e8c68"; bg = "black"; };
        "ui.statusline" = { fg = "#00d8bf"; bg = "black"; };

        pallet = {
          background = "#1f1f1f";
          black = "#0f0f0f";
        };
      };
    };
  };
}
