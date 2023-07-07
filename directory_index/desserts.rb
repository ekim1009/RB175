require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir.glob("public/*").sort
  if params[:sort] == "descending"
    @files.reverse!
  end
  erb :home
end