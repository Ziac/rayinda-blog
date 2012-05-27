class AccessRule < ActiveRecord::Base
  belongs_to :permission
  belongs_to :role
  # attr_accessible :title, :body
end
