class Post < ActiveRecord::Base
  belongs_to :user
  scope :latest ,order('update_at desc')
  has_many :comments, dependent: :destroy
  has_many :users
  acts_as_mappable(:default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude)

end