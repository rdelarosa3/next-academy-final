RailsAdmin.config do |config|

  ## == Clearance ==
  config.parent_controller = "::ApplicationController"

  config.authorize_with do |controller|
    unless current_user && (current_user.admin? || current_user.operator?)
      redirect_to(
        main_app.root_path,
        alert: "You are not permitted to view this page"
      )
    end
  end

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show 
    edit
    delete
    ####### modify action in admin panel #########
    show_in_app do
      except ['Reservation','Content','Business','Service']
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show

  end

  ######## remove models from navigation pane #######
  config.excluded_models << "Authentication"


  ###### config User model ############
  config.model User do

    navigation_label 'Customer Info'
    object_label_method do
      :custom_label_method
    end

    list do
      x = [:avatar,:confirmation_token,:updated_at,:created_at,:birthday,:gender,:role,:notes]
      x.each do |y|
        configure y do
          hide
        end
      end
    end

    update do
      exclude_fields :password, :password_confirmation, :authentications, :confirmation_token
    end

    create do
      exclude_fields :authentications, :confirmation_token, :reservations
    end
  end

  ######## config Service model ##########
  config.model Service do


    navigation_label 'Salon Info'
    create do
      exclude_fields :reservations
    end
    update do
      exclude_fields :reservations
    end
  end

  ######## config Business model ##########
  config.model Business do
    navigation_label 'Salon Info'
    list do
      x = [:facebook,:instagram,:youtube,:logo,:twitter,:updated_at,:created_at]
      x.each do |y|
        configure y do
          hide
        end
      end
    end
  end

  ######## config Content model ##########
  config.model Content do
    navigation_label 'Salon Info'
  end

  ######## config Reservation model ##########
  config.model Reservation do
    navigation_label 'Customer Info'
  end

  ######## config ServiceType model ##########
  config.model ServiceType do
    navigation_label 'Salon Info'
    list do
      configure :notes do
        hide
      end
    end
  end

  config.model BusinessHour do
    navigation_label 'Salon Info'
        object_label_method do
      :custom_label
    end
    list do
      configure :created_at do
        hide
      end
      configure :business do
        hide
      end
    end
  end

end


