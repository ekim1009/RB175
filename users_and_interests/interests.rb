require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

before do
  @information = YAML.load_file("users.yaml")
end

get "/" do
  erb :home
end

get "/:user" do
  @friend = params[:user].to_sym
  @interests = @information[@friend][:interests]
  
  erb :friend
end


    # <% values = [] %>
    # <% values = @information.each do |nest| %>
    #   <% values << nest[:interests].count %>
    # <% end %>
    
        # <p>There are a total of <%= @information.keys.count %> friends and <% values.total %> interests</p>