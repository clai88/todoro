class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  validates :name, uniqueness: true
end
