vim.api.nvim_exec([[command Rroutes Einitializer]], true)
vim.api.nvim_exec([[command Eroutes Einitializer]], true)

vim.g.rails_projections = {
      ["app/services/*.rb"] = {
            ["command"] = "service",
            ["test"] = "spec/services/{}_spec.rb",
            ["template"] = "class %S\n\n  def run\n  end\nend",
      },
      ["app/decorators/*_decorator.rb"] = {
            ["command"] = "decorator",
            ["related"] = "app/models/{}.rb",
            ["affinity"] = "model",
            ["template"] = "Fabricator :{} do\n\nend",
      },
      ["spec/factories/*.rb"] = {
            ["command"] = "factory",
            ["related"] = "app/models/{}.rb",
            ["affinity"] = "model",
            ["template"] = "FactoryBot.define do \n factory :{} do\n\nend\nend",
      },
      ["spec/fabricators/*_fabricator.rb"] = {
            ["command"] = "fabricator",
            ["related"] = "app/models/{}.rb",
            ["affinity"] = "model",
            ["template"] = "Fabricator :{} do\n\nend",
      },
      ["app/javascript/packs/*.js"] = {
            ["command"] = "pack",
      },
      ["app/javascript/*.js"] = {
            ["command"] = "js",
      },
      ["config/locales/*de.yml"] = { ["alternate"] = "%sen.yml" },
      ["config/locales/*en.yml"] = { ["alternate"] = "%sde.yml" },
      ["config/*.rb"] = {
            ["command"] = "config",
      },
}
