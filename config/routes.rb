Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  get "dogs", to: "pages#dogs"
  resources :user, only: %i[show]

  # admin CRUD routes

  namespace :admin do
    ApplicationRecord.admin_resources.each do |admin_resource|
      resources admin_resource do
        admin_resource.s_to_model.show_lists.each do |list|
          resources list, only: %i[] do
            collection do
              match 'search' => "#{admin_resource}#search",
                via: %i[get post],
                as: :search,
                defaults: { parent_model: admin_resource.classify, model: list.classify }
            end
          end
        end
        collection do
          match 'search' => "#{admin_resource}#search", via: %i[get post], as: :search
        end
      end
    end

    # resources :products do
    #   Product.show_lists.each do |list|
    #     resources list, only: %i[index] do
    #       match 'search' => 'products#search' , via: [:get, :post], as: :search
    #     end
    #   end
    #   collection do
    #     match 'search' => 'products#search', via: [:get, :post], as: :search
    #   end
    # end
    # resources :users do
    #   User.show_lists.each do |list|
    #     resources list, only: %i[index] #do
    #     #   match 'search' => ''
    #     # end
    #   end
    #   collection do
    #     match 'search' => 'users#search', via: [:get, :post], as: :search
    #   end
    # end
    #   scope ':resource_name', resource_name: /#{ApplicationRecord.admin_models.join('|')}/ do
    #   # scope ':resource_name' do
    #   get    '/'                      => 'data#index',          as: 'data_index'
    #   get    '/:id'                   => 'data#show',           as: 'data_show'
    #   post   '/'                      => 'data#create',         as: 'data_create'
    #   put   '/:id'                   => 'data#update',         as: 'data_update'
    #   patch  '/:id'                   => 'data#update',         as: 'data_update_patch'
    #   # post   '/:id/rotate'            => 'data#rotate_image',   as: 'rotate_image'
    #   # post   '/:id/bookmark/:index'   => 'data#bookmark_image', as: 'bookmark_image'
    #   # post   '/:id/:index'            => 'data#delete_image',   as: 'delete_image'
    #   delete '/:id'                   => 'data#destroy',        as: 'data_destroy'
    # end
  end
end

# admin/users/#{id}/orders/
