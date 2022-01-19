vim.api.nvim_exec([[command Rroutes Einitializer]], true)
vim.api.nvim_exec([[command Eroutes Einitializer]], true)

local vim_rails = {}
vim_rails.config = function()
      vim.g.rails_projections = {
            ["app/services/*.rb"] = {
                  ["command"] = "service",
                  ["affinity"] = "model",
                  ["related"] = "app/models/{}.rb",
                  ["test"] = "spec/services/{}_spec.rb",
                  ["template"] = "class %S\n\n  def run\n  end\nend",
            },
            ["app/decorators/*_decorator.rb"] = {
                  ["command"] = "decorator",
                  ["related"] = "app/models/{}.rb",
                  ["affinity"] = "model",
                  ["template"] = "Fabricator :{} do\n\nend",
            },
            ["spec/decorators/*_fabricator.rb"] = {
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
end
return vim_rails
