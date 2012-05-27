class Permission < ActiveRecord::Base
  attr_accessible :action, :controller, :name
end
