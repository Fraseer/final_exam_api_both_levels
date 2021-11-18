class Api::CommentsController < ApplicationController
  def create
    comment = Comment.new(body: params[:comment][:body])
    comment.user = User.find_by(name: params[:comment][:user])
    comment.article = Article.find_by(title: params[:comment][:article])
    comment.save

    if comment.persisted?
      render json: { message: 'You have successfull left a comment.' }, status: 201
    else
      render json: {error: 'You must enter some text to leave a comment.'}, status: 422
    end
  end
end
