class UserStepsController < ApplicationController
	include Wicked::Wizard
	steps :enter_improvement, :enter_address

	def show
		render_wizard
end
