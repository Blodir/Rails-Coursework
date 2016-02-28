class Style < ActiveRecord::Base
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers
  validates :name, presence: true

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.average_rating||0) }
    sorted_by_rating_in_desc_order.take(n)
  end
end
