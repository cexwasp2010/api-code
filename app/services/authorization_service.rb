class AuthorizationService
  class TokenError < StandardError
    def message
      "Token o perfil invalido para consumir este servicio en el API"
    end
  end

  class AuthorizationError < StandardError
    def message
      'No se ha enviado el parámetro: Authorization con el token de acceso en el header'
    end
  end

  def initialize(headers = {}, action_name)
    @headers = headers
    @action_name = action_name
  end

  def authenticate_request!
    verify_token
  end

  private

  def http_token
    if @headers['Authorization'].present?
      @headers['Authorization'].split(' ')
    else
      raise AuthorizationError
    end
  end

  def verify_token
    raise TokenError if (http_token.last != ENV[http_token.first+'_token'] or (@action_name != "show" and http_token.first == "user"))
  end

end