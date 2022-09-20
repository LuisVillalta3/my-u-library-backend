class JsonWebToken
  SECRET_KEY = 'b46f9fd955a29b47ed9c8554b10ea7672c6872360b222ceead97a098b1049fba199cf187533c2979eda378407a96f4d0a15a1812f4dcf3aad2272c56081e7d8f'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
