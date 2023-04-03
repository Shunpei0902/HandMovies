class CommentsController < ApplicationController
    before_action :set_movie
    before_action :authenticate_user!

    def create
        @comment = @movie.comments.build(comment_params)
        if @comment.save
          redirect_to @movie
        else
          render 'movies/show'
        end
      end

   
    def destroy
        @comment = @movie.comments.find(params[:id])
        if @comment.user == current_user
            @comment.destroy
            redirect_to @movie, notice: "コメントを削除しました。"
        else
            redirect_to @movie, alert: "不正なアクセスです。"
        end
    end
    
    private

    def set_movie
        @movie = Movie.find(params[:movie_id])
    end

    def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id, movie_id: params[:movie_id])
        #params.require(:comment).permit(:content, :user_id, :movie_id)
    end
end