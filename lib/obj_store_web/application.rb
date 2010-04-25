require 'obj_store'

require 'obj_store_web/foo'

module ObjStoreWeb
  class Application < Sinatra::Base
    configure do
      ObjStore.set(:foos, [])
    end
    
    def index
      @foos = ObjStore.get(:foos)
      erb :index
    end
    
    get('/') do
      index
    end
    
    get('/foos') do
      index
    end
    
    post('/foos') do
      foo = Foo.new
      foo.name = params[:foo][:name]
      ObjStore.set(:foos, (ObjStore.get(:foos) + [foo]))
      redirect '/'
    end
    
    get('/foos/:id') do
      @foo = ObjStore.get(:foos).detect { |foo| foo.id == params[:id].to_i }
      
      unless @foo
        return "Could not find foo with id of #{params[:id]}"
      end
      
      erb :show
    end
    
    get('/foos/:id/edit') do
      @foo = ObjStore.get(:foos).detect { |foo| foo.id == params[:id].to_i }
      
      unless @foo
        return "Could not find foo with id of #{params[:id]}"
      end
      
      erb :edit
    end
    
    put('/foos/:id') do
      @foo = ObjStore.get(:foos).detect { |foo| foo.id == params[:id].to_i }
      
      unless @foo
        return "Could not find foo with id of #{params[:id]}"
      end
      
      @foo.name = params[:foo][:name]
      redirect "/"
    end
    
    delete('/foos/:id') do
      foos = ObjStore.get(:foos)
      @foo = foos.detect { |foo| foo.id == params[:id].to_i }
      
      unless @foo
        return "Could not find foo with id of #{params[:id]}"
      end
      
      foos.delete(@foo)
      ObjStore.set(:foos, foos)
      redirect '/'
    end
  end
end