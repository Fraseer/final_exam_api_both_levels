RSpec.describe Comment, type: :model do
  describe 'Database Table' do
    it { is_expected.to have_db_column :body }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :body }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :articles }
    it { is_expected.to belong_to :users }
  end

  describe 'Factory' do
    it 'is expected to have a valid factory' do
      expect(create(:comment)).to be_valid
    end
  end
end