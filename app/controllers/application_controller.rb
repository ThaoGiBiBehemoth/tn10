class ApplicationController < ActionController::API
  def encode_token(payload)
    payload[:exp] =  30.days.after.to_i
    JWT.encode(payload, 'thaogibi')
  end

  def decode_token
    auth_header = request.headers['Authorization']

    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'thaogibi', true, alg: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end  
end
