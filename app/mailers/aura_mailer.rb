class AuraMailer < ApplicationMailer
	def sample_mail(user)
		@user = user
		mail(to: @user.email, subject: 'Sample Email')
		
	end
end
