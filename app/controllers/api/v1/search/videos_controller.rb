module Api
  module V1
    module Search
      class VideosController < BaseSearchController
      
        def create
          ::Search::Videos::Create.call(current_api_user, params) do |success, failure|
            success.call {|videos| success_response(200, videos)}
            failure.call(&method(:error_response))
          end
        end
        
      end
    end
  end
end