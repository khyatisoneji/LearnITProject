class PingController < ActionController::API
    def ping
    render json: { message: 'pong' }, status: 200
    end
    end
    