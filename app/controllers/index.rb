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
    session[:user_id] = User.find_by_email(params[:email]).id
    redirect '/create_url'
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
    session[:user_id] = User.find_by_email(params[:email]).id
    redirect '/create_url'
  else
    @message = 'Go FUCK yourself. (could not create account)'
    erb :create_account
  end
end

# get '/secret_page' do
#   @user = session[:user_id]
#   if @user
#     erb :secret_page
#   else
#     session[:message] = 'NICE TRY FUCKER'
#     redirect '/login'
#   end
# end

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end


get '/create_url' do
  @user = User.find(session[:user_id])
  erb :create_url
end

post '/create_url' do
  @url = Url.find_or_create_by_url(params[:url])# create a new Url
  @user = User.find(session[:user_id])
  @urls_user = UrlsUser.find_by_user_id_and_url_id(@user.id, @url.id)

  if @url.valid? && @urls_user.nil?
    @user.urls << @url
  else
    @url_errors = @url.errors
    @urls_user_errors = @urls_user.errors unless @urls_user.nil?
  end

  erb :create_url
end

# e.g., /q6bda
get '/:tiny_url' do
  url = Url.find_by_tiny_url(params[:tiny_url])
  url.click_count = url.click_count + 1
  url.save
  redirect "#{url.url}"
end
