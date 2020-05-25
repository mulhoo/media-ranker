require "test_helper"

describe Work do
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
  end
  
end
