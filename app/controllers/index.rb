get '/' do
  erb :create_url
end

post '/url' do
  @url = Url.create(params)# create a new Url
  erb :show_url
end

# e.g., /q6bda
get '/:tiny_url' do
  url = Url.find_by_tiny_url(params[:tiny_url])
  url.click_count = url.click_count + 1
  url.save
  redirect "#{url.url}"
end
