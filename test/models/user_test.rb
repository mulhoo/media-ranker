require "test_helper"

describe User do
  let (:new_user) {
    new_user = User.new(name: "Light Yagami")
  }

  it "can be instantiated" do
    expect(new_user.valid?).must_equal true
  end

  it "has required fields" do
    new_user.save
    user = User.first
    [:name].each do |field|
      expect(user).must_respond_to field
    end
  end

  describe "relationships" do
    it "has many votes" do
      new_user.save
      user = User.first

      expect(user.votes.count).must_be :>=, 0
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "requires a name" do
      new_user.name = nil

      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :name
      expect(new_user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  describe "custom method - works_by_user" do
    before do
      @work_1 = Work.create(category: "book", title: "DeathNote", creator: "Tsugumi Ohba", publication_year: 2003, description: "angsty teenage boy plays god")
      @work_2 = Work.create(category: "album", title: "Future Nostalgia", creator: "Dua Lipa", publication_year: 2020, description: "Dua Lipa's debut album")

      @user_1 = User.create(name: "Light Yagami")
      @user_2 = User.create(name: "L")
      
      @vote_1 = Vote.create(user_id: @user_1.id, work_id: @work_1.id)
      @vote_2 = Vote.create(user_id: @user_2.id, work_id: @work_1.id)
      @vote_3 = Vote.create(user_id: @user_1.id, work_id: @work_2.id)
    end

    it "shows work by user" do
      works = @user_1.works_by_user
      expect(works[0].id).must_equal @work_1.id
      expect(works[1].id).must_equal @work_2.id
    end
  end
end

