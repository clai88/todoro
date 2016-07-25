class Task < ActiveRecord::Base
  belongs_to :list
  validates :name, uniqueness: true
end
