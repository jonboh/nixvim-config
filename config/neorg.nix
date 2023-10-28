{
  plugins.neorg = {
    enable = true;
    modules = {
      "core.concealer" = { __empty = null; };
      "core.defaults".__empty = null;
      "core.dirman".config.workspaces = {
        vault = "~/doc/vault";
      };
    };
  };
}
