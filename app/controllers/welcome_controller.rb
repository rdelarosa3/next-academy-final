class WelcomeController < ApplicationController
	

  def homepage
  	@staff = User.all.where(role: :admin)
  end

end
