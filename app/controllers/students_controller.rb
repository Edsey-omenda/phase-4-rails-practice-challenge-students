class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def index
        render json: Student.all
    end

    def show
        render json: Student.find(params[:id])
    end

    def create
        student = Student.create(student_params)
        render json: student, status: :created
    end

    def update
       student = Student.find_by(id: params[:id])
        if student
         student.update(student_params)
          render json:student
        else
          render json: { error: "Student not found" }, status: :not_found
        end
      end

    def destroy
        student = Student.find(params[:id])
        if student
            student.destroy
            head :no_content
            render json: {}
    
        else
            render json: { error: "Student not found" }, status: :not_found
        end
       end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: ["Validation errors!"] }, status: :unprocessable_entity
      end
end
