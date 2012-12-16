class LikesController < ApplicationController

	def create
		@like = Like.new(params[:like])
		respond_to do |format|
			if @like.save
				format.json { render json: @like, status: :created, location: @like }
				format.js
			else
				format.json { render json: @like.errors, status: :unprocessable_entity }
				format.js
			end
		end
	end

  # DELETE /likes/1
  # DELETE /likes/1.json
	def destroy
		@like = Like.find(params[:id])
		@exercise = @like.likable
		@like.destroy
		respond_to do |format|
			format.json { head :no_content }
			format.js
		end
	end

end
