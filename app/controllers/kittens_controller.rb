class KittensController < ApplicationController
    def index
        @kittens = Kitten.all
    end

    def show
        @kitten = Kitten.find(params[:id])
    end

    def new
        @kitten = Kitten.new
    end

    def create
        @kitten = Kitten.new(allowed_params)

        if @kitten.save
            flash[:notice] = "Meow! We have a new kitten!"
            redirect_to @kitten
        else
            flash.now[:alert] = "Kitten creation was failed!"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end

    def update
        @kitten = Kitten.find(params[:id])

        if @kitten.update(allowed_params)
            flash[:notice] = "Prrr! Kitten was updated successfully!"
            redirect_to @kitten
        else
            flash.now[:alert] = "Update was unsuccessful!"
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @kitten = Kitten.find(params[:id])
        @kitten.destroy

        flash[:notice] = "A kitten was successfully and tragically deleted!"
        redirect_to root_path, status: :see_other
    end

    
    private

    def allowed_params
        params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
