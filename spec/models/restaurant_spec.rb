require 'rails_helper'

describe Restaurant, type: :model do

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  before do
  end
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    @user = User.create(email: 'ben@ben.com', password: 'ben123')
    @restaurant = Restaurant.create(name: "Moe's Tavern", user: @user)
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe 'reviews' do
  describe 'build_with_user' do

    let(:user) { User.create email: 'test@test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }

    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

    it 'builds a review' do
      expect(review).to be_a Review
    end

    it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
    end
  end
end

describe Restaurant do
  it { should have_attached_file(:image) }
  # it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
                  allowing('image/png', 'image/gif').
                  rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:image).
                  less_than(2.megabytes) }
end


end
