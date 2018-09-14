class SessionsController < Clearance::SessionsController

  # Ominauth sign in and create
  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

    # if: previously already logged in with OAuth
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = callback #redirect back to current
      @notice = "Signed in!"
    # else: user logs in with OAuth for the first time
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      # you are expected to have a path that leads to a page for editing user details
      @next = edit_user_path(user)
      @notice = "User created. Please confirm or edit details"
    end

    sign_in(user)  
    redirect_to @next, :notice => @notice
  end

  #replaced Clearance route
  def destroy
    sign_out
    redirect_to root_url
  end

  #replaced Clearance route
  def create
    @user = authenticate(params)
    sign_in(@user) do |status|
      if status.success?
        if URI(request.referer).path == '/reservations/new'
          redirect_to new_reservation_path, notice: "Welcome" 
        else 
         redirect_to root_url
        end
      else
        flash.now.notice = status.failure_message
        render template: "sessions/new", status: :unauthorized
      end
    end    
  end

  #redirect back to current path when Omniauth
  def callback
    request.env['omniauth.origin'] || '/default'
  end

  def show
    redirect_to root_url
  end


end
