class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: { status: { code: 200, message: "Signed up successfully." }, data: resource }, status: :ok
    else
      render json: { status: { code: 422, message: "User could not be created", errors: resource.errors.full_messages } }, status: :unprocessable_content
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def respond_with(resource, _opts = {})
    render json: resource
  end
end
