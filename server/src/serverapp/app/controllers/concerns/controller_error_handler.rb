module ControllerErrorHandler
    def handle_error(error)

        if error.is_a? ActiveRecord::RecordNotFound
            render plain:"Not found", status: :not_found
        end 

        #should make a custom exception
        if error.message == "This record belongs to another user"
            render plain:error.message, status: :forbidden
        end 

    end
end 