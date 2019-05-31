Dmr::Engine.routes.draw do
  get '/new', to: 'defective_materials#new'
  get '/request', to: 'defective_materials#get_so_info'
  get '/(:id)', to: 'defective_materials#show'
end
