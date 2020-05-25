require "test_helper"

describe Vote do
  let (:new_vote) {
    work_1 = Work.new(category: "album", title: "Future Nostalgia", creator: "Dua Lipa", publication_year: 2020, description: "Dua Lipa debut album")
    user_1 = User.new(username: "Light Yagami")
    
    new_vote = Vote.new(user: user_1, work: work_1)
  }

  
  describe "validations" do
    it "must have a user" do
      new_vote.user = nil

      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :user
      expect(new_vote.errors.messages[:user]).must_equal ["must exist", "can't be blank"]
    end
    
    it "must have a work" do
      new_vote.work = nil
      
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :work
      expect(new_vote.errors.messages[:work]).must_equal ["must exist", "can't be blank"]
    end
  end
end
