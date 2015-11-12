class RecipesController < ApplicationController
    before_action :set_recipe, only: [:edit, :update, :show, :like]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update]

    def index
      @recipes = Recipe.paginate(page: params[:page], per_page: 4)
      #Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
    end

    def show
      #binding.pry
      
    end

    def new
      @recipe = Recipe.new
    end

    def edit
      
    end

    def create
      @recipe = Recipe.new(recipe_params)
      @recipe.chef = current_user  #Chef.find(2)

      if @recipe.save
        flash[:success] = "Your recipe was created successfully."
        redirect_to recipes_path
      else
        render :new
      end

    end

    def update
       
       if @recipe.update(recipe_params)
         flash[:success] = "Your recipe updated successfully."
         redirect_to recipe_path(@recipe)
       else
         render :edit
       end
    end

    def like
      
      like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
      if like.valid?
         flash[:success] = "Your selection was successful."
      else
         flash[:danger] = "You can like/dislike only once."
      end
      redirect_to :back
    end

    private
      def recipe_params
        params.require(:recipe).permit(:name, :summary, :description, :picture)
      end

      def set_recipe
        @recipe = Recipe.find_by_id(params[:id])
      end

      def require_same_user
        if current_user != @recipe.chef
          flash[:danger] = "You can only edit your own recipe"
          redirect_to recipes_path
        else

        end
      end
end

