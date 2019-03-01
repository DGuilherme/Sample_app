class User < ApplicationRecord
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  
  
  has_secure_password  #metodo que permite q«guardar de forma segura a password pois usa a "password_digest" atributo da base de dados

  validates :password, presence: true, length: { minimum: 6 }


#usa bcrypt via has_secure_password
#no password create string -> que vai sofrer a açao do hash e o cost é o custo computacional para calcular o hash para testes o custo é baixo para produção é alto!!!

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) 
  end

end
