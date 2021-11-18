RSpec.describe 'POST /api/comments', type: :request do
  let!(:article) { create(:article, title: 'article') }
  let!(:user) { create(:user, name: 'Fraser') }
  let!(:credentials) { user.create_new_auth_token }

  describe 'succesful creation of comment' do
    before do
      post '/api/comments', params: { comment: {
        body: 'I have left a comment.',
        user: 'Fraser',
        article: 'article'
      } },
                            headers: credentials
    end
    it 'is expected to return a 201 response' do
      expect(response).to have_http_status 201
    end

    it 'is expected that return a success message' do
      expect(response_json['message']).to eq 'You have successfull left a comment.'
    end

    it 'is expected that there will be one comment on the article' do
      expect(article.comments.count).to eq 1
    end

    it 'is expected that the user will have one comment on their account' do
      expect(user.comments.count).to eq 1
    end
  end

  describe 'unsuccesful creation of comment' do
    describe 'when the body has no content' do
      before do
        post '/api/comments', params: { comment: {
          body: '',
          user: 'Fraser',
          article: 'article'
        } },
                              headers: credentials
      end
      it 'is expected to return a 422 response' do
        expect(response).to have_http_status 422
      end

      it 'is expected to render a unsuccessful message' do
        expect(response_json['errors']).to eq 'You must enter some text to leave a comment.'
      end

      it 'is expected that there will not be a comment on the article' do
        expect(article.comments.count).to eq 0
      end
    end

    describe 'when the user is not authorized' do
      before do
        post '/api/comments', params: { comment: {
          body: 'I have left a comment.',
          user: 'Fraser',
          article: 'article'
        } }
      end

      it 'is expected to return a 401 response' do
        expect(response).to have_http_status 401
      end

      it 'is expected to return a unsuccessful message' do
        expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
      end

      it 'is expected that there will not be a comment on the article' do
        expect(article.comments.count).to eq 0
      end
    end
  end
end
