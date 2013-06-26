enable :sessions

get '/' do
  redirect '/login'
end

get '/login' do
  @message = session[:message]
  session[:message] = nil
  erb :login
end

post '/login' do
  if User.authenticate(params[:email], params[:password])
    session[:user] = User.find_by_email(params[:email])
    redirect '/secret_page'
  else
    session[:message] = 'Go FUCK yourself. (login failed)'
    redirect '/login'
  end
end

get '/create_account' do
  @message = session[:message]
  session[:message] = nil
  erb :create_account
end

post '/create_account' do
  # if User.create(email: params[:email], password: params[:password], name: params[:name])
  if User.new(params).save
    session[:user] = User.find_by_email(params[:email])
    redirect '/secret_page'
  else
    @message = 'Go FUCK yourself. (could not create account)'
    erb :create_account
  end
end

get '/secret_page' do
  @user = session[:user]
  if @user
    erb :secret_page
  else
    session[:message] = 'NICE TRY FUCKER'
    redirect '/login'
  end
end

get '/logout' do
  session[:user] = nil
  redirect '/login'
end


# get '/' do
#   erb :create_url
# end

post '/url' do
  @url = Url.create(params)# create a new Url
  if @url.errors.any?
    @errors = @url.errors
    erb :create_url
  else
    erb :show_url
  end
end

# e.g., /q6bda
get '/:tiny_url' do
  url = Url.find_by_tiny_url(params[:tiny_url])
  url.click_count = url.click_count + 1
  url.save
  redirect "#{url.url}"
end

