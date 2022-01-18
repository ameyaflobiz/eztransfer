module Errorhandler
	extend ActiveSupport::Concern

	included do
		rescue_from StandardError, with: :show_errors
	end

	def show_errors(exception)
		render json: { message: "Error Caught by Global Handler", exception: exception}
	end
end