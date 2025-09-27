{pkgs, ...}: {
  extraPlugins = [(pkgs.callPackage ../plugins/anki.nix {})];
  extraConfigLua = ''
    require("anki").setup({
      -- this function will add support for associating '.anki' extension with both 'anki' and 'tex' filetype.
      tex_support = true,
      models = {
        -- Here you specify which notetype should be associated with which deck
        ["MathematicsBasic"] = "Mathematics",
        ["DynamicalSystemsBasic"] = "DynamicalSystems",
        ["StatisticsBasic"] = "Statistics",
        ["MachineLearningBasic"] = "MachineLearning",
      },
      linters = require("anki.linters").default_linters();
    })
  '';
}
