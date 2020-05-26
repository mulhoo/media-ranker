require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "album", title: "Dedicated", creator: "Carly Rae Jepsen", publication_year: 2019, description: "CRJ kills it again on album #3")
  }
  
  it "can be instantiated" do
    expect(new_work.valid?).must_equal true
  end
  
  it "has the required fields" do
    new_work.save
    work = Work.first
  
    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "has many votes" do
      new_work.save
      work = Work.first
  
      expect(work.votes.count).must_be :>=, 0
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
    
  describe "validations" do
    it "requires a title" do
      new_work.title = nil
 
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
      
    it "requires a creator" do
      new_work.creator = nil
  
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :creator
      expect(new_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end
  end

  describe "customs" do
    before do
      @work_1 = Work.create(category: "book", title: "DeathNote", creator: "Tsugumi Ohba", publication_year: 2003, description: "angsty teenage boy plays god")
      @work_2 = Work.create(category: "book", title: "Harry Potter", creator: "JK Rowling", publication_year: 2000, description: "you're a wizard, Harry")

      @user_1 = User.create(name: "Light Yagami")
      @user_2 = User.create(name: "L")
      
      @vote_1 = Vote.create(user_id: @user_1.id, work_id: @work_1.id)
      @vote_2 = Vote.create(user_id: @user_2.id, work_id: @work_1.id)
      @vote_3 = Vote.create(user_id: @user_1.id, work_id: @work_2.id)
    end

    it "finds the top work" do
      expect(Work.top.id).must_equal @work_1.id
    end

    it "returns nothing if there are no votes" do
      Vote.destroy_all
      expect(Work.top).must_equal nil
    end

    it "sorts works by category" do
      sorted = Work.sort("book")
      expect(sorted[0].id).must_equal @work_1.id
      expect(sorted[1].id).must_equal @work_2.id
    end
  end
end
