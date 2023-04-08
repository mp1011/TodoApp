class HelloWorldController < ApplicationController

    def say
        @x = params[:x]
        render plain: "Hello #{@x}"
      end

end
