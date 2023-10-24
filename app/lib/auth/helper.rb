class Auth::Helper

  def self.bearer(request)
    pattern = /^Bearer /i
    header = request.headers['Authorization']
    header.gsub(pattern, '') if header && header.match(pattern)
  end

  def self.current_account(request, params_token)
    token = params_token || bearer(request)
    if token
      Account.where(token: token).limit(1).first
    else
      nil
    end
  end

end
