require 'sinatra/base'
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/lib'))

Sinatra::Base.set :run, false
Sinatra::Base.set :root, File.expand_path(File.dirname(__FILE__))
Sinatra::Base.set :static, true
Sinatra::Base.set :method_override, true
require 'obj_store_web/application'

run ObjStoreWeb::Application
