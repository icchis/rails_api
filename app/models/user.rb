class User < ActiveRecord::Base

  # before_save :ensure_authentication_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # before_filter :token_authenticatable
  has_many :posts
  acts_as_mappable(:default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :my_latitude,
                   :lng_column_name => :my_longitude)

  before_save :ensure_authentication_token

  # authentication_tokenが無い場合は生成して設定
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
  # You likely have this before callback set up for the token.
  # before_save :ensure_authentication_token

  # def ensure_authentication_token
  #   if authentication_token.blank?
  #     self.authentication_token = generate_authentication_token
  #   end
  # end

  # private

  # def generate_authentication_token
  #   loop do
  #     token = Devise.friendly_token
  #     break token unless User.where(authentication_token: token).first
  #   end
  # end

end
