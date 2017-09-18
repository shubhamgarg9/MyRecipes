class Like < ActiveRecord::Base
	belongs_to :chef
	belongs_to :recipe

	validates_uniqueness_of :chef, scope: :recipe   # like and dislike allowed only once not dependent on recipes
end