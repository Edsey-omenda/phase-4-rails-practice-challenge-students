class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    

    def index
        render json: Instructor.all
    end

    def show
        render json: Instructor.find(params[:id])
    end

    def create
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find_by(id: params[:id])
        if instructor
          instructor.update(instructor_params)
          render json: instructor
        else
          render json: { error: "Instructor not found" }, status: :not_found
        end
      end

    def destroy
    instructor = Instructor.find(params[:id])
    if instructor
        instructor.destroy
        head :no_content
        render json: {}

    else
        render json: { error: "Instructor not found" }, status: :not_found
    end
   end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: ["Validation errors!"] }, status: :unprocessable_entity
      end
end
