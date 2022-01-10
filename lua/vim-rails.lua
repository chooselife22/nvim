vim.api.nvim_exec([[command Rroutes Einitializer]], true)
vim.api.nvim_exec([[command Eroutes Einitializer]], true)

local vim_rails = {}
vim_rails.config = function()
      vim.g.rails_projections = {
            ["spec/decorators/*_decorator.rb"] = {
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
            ["app/services/*.rb"] = {
                  ["command"] = "service",
                  ["affinity"] = "model",
                  ["test"] = "spec/services/%s_spec.rb",
                  ["related"] = "app/models/%s.rb",
                  ["template"] = "class %S\n\n  def run\n  end\nend",
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
