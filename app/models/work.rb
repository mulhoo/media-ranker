class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: {scope: :category}
  validates :creator, presence: true

  def self.featured
    return nil if Vote.count == 0

    featured_work = Work.all.max_by do |work|
      work.votes.count
    end

    return featured_work
  end

  def self.sort(medium)
    sort_work = Work.all.where(medium: medium).limit(10).sort_by do |work|
      work.votes.count
    end

    return sort_work
  end
end
