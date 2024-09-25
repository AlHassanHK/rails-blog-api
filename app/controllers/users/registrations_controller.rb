# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private
    def respond_with(resource, options = {})
      if resource.persisted?
        render json: {
          status: { code: 200,
          message: "Successfully signed up",
          data: resource }
        }

      else
        render json: {
          status: { message: "User could not be created", error: reosurce.errors.full_messages }
        }
      end
    end
end
