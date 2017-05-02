require 'csv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  client = DropboxApi::Client.new
  results = client.search("credentials.csv")
  if results.matches.count > 0
    path = results.matches.first.resource.path_lower
    file_contents = ""
    file = client.download(path) do |chunk|
      file_contents << chunk
    end
    contentArr = file_contents.split(',')
    user = file_contents[0]
    puts user
    pass = file_contents[1]
    puts pass
    http_basic_authenticate_with :name => user, :password => pass
  end


end
