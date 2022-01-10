command! Eroutes Einitializer
command! Rroutes Einitializer
" https://raw.githubusercontent.com/tpope/vim-rails/master/doc/rails.txt
let g:rails_projections = {
      \ "spec/fabricators/*_fabricator.rb": {
      \   "command": "fabricator",
      \   "related": "app/models/{}.rb",
      \   "affinity": "model",
      \   "template": [ "Fabricator :{} do", "end"],
      \   "keywords": "delegate_all decorates_association object h"
      \ },
      \ "app/decorators/*_decorator.rb": {
      \   "command": "decorator",
      \   "related": "app/models/{}.rb",
      \   "affinity": "model",
      \   "test": "spec/decorators/%s_spec.rb",
      \   "template": [
      \     "class {camelcase|capitalize|colons}Decorator < Draper::Decorator",
      \     "end"
      \   ],
      \   "keywords": "delegate_all decorates_association object h"
      \ },
      \ "app/javascript/*.js": {
      \   "command": "pack",
      \ },
      \ "app/javascript/*.vue": {
      \   "command": "vue",
      \ },
      \ "app/javascript/controllers/*_controller.js": {
      \   "command": "reflexjs",
      \   "template": ["import ApplicationController from './application_controller'", "", "export default class extends ApplicationController {", "}"],
      \ },
      \ "app/services/*.rb": {
      \   "command": "service",
      \   "template": ["class {camelcase|capitalize|colons}", "end"],
      \   "test": [ "spec/services/{}_spec.rb" ],
      \   "rubyMacro": ["process", "version"]
      \ },
      \ "app/forms/*_form.rb": {
      \   "command": "form",
      \   "related": "app/models/{}.rb",
      \   "affinity": "model",
      \   "template": ["class {camelcase|capitalize|colons}Form", "end"],
      \   "test": [ "spec/forms/{}_spec.rb" ],
      \ },
      \ "app/components/*/component.rb": {
      \   "related": "app/components/{}/component.html.slim",
      \   "command": "c",
      \   "template": ["class {camelcase|capitalize|colons}::Component < ViewComponent::Base", "end"],
      \   "test": [ "spec/components/{}_component_spec.rb" ],
      \   "rubyHelper": [ "helpers"],
      \ },
      \ "app/components/*/component.html.slim": {
      \   "related": "app/components/{}/component.rb",
      \   "rubyAction": ["content"],
      \   "command": "cv",
      \ },
      \ "app/components/*/component.js": {
      \   "command": "cjs",
      \ },
      \ "app/components/*/component.css": {
      \   "command": "cstyle",
      \ }
      \ }
