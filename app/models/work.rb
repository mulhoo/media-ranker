class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: {scope: :category}
  validates :creator, presence: true

  def self.top
    return nil if Vote.count == 0

    top_work = Work.all.max_by do |work|
      work.votes.count
    end

    return top_work
  end

  def self.sort(medium)
    sort_work = Work.all.where(medium: medium).limit(10).sort_by do |work|
      work.votes.count
    end

    return sort_work
  end
end
