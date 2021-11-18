RSpec.describe 'POST /api/comments', type: :request do
  let(:article) { create(:article) }
  before do
    post '/api/comments', params: {
      body: 'I have left a comment.'
    }
  end

  describe 'succesful' do
    it { is_expected.to have_http_status 201 }

    it 'is expected that return a success message' do
      expect(response_json['message']).to eq 'You have successfull left a comment'
    end

    it 'is expected that there will be one comment on the article' do
      expect(Article.last.comments).to eq 1
    end

    it 'is expected that the comment will be what is sent in the params' do
      expect(Article.last.comments[0]).to eq 'I have left a comment.'
    end
  end
end
