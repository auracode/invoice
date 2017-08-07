class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.customers
   @user = User.first
   require 'net/http'
   source = @user.api_source
   resp = Net::HTTP.get_response(URI.parse(source))
   data = resp.body
   @result = JSON.parse(data)
  end
end
