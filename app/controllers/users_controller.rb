class UsersController < Clearance::UsersController
before_action :set_user, only: [:show, :edit, :update, :destroy]
	
	# POST /users
  	# POST /users.json
	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_url
		else
			redirect_to sign_up_path
		end
	end

	# PATCH/PUT /users/1
	# PATCH/PUT /users/1.json
	def update
		
		respond_to do |format|
		  if @user.update(user_params)
		    format.html { redirect_to @user, notice: 'Profile successfully updated.' }
		    format.json { render :show, status: :ok, location: @user }
		   	format.js
		  else
		    format.html { render :edit }
		    format.json { render json: @user.errors, status: :unprocessable_entity }
		    format.js
		  end
		end
	end


  	# GET /users/1
 	# GET /users/1.json
	def show
		@user = User.find(params[:id])
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :first_name, :last_name, :birthday, :password, :gender, :avatar, :phone_number, :notes, :remove_avatar)
	end
end