class User < ApplicationRecord
  
  attr_accessor :remember_token					#REMINDER: é como o getter e o setter
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  
  
  has_secure_password  #metodo que permite q«guardar de forma segura a password pois usa a "password_digest" atributo da base de dados

  validates :password, presence: true, length: { minimum: 6 }, allow_nil:true


  #usa bcrypt via has_secure_password
  #no password create string -> que vai sofrer a açao do hash e o cost é o custo computacional para calcular o hash para testes o custo é baixo para produção é alto!!!

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) 
  end

  # Returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # preciso um metodo que associe a token ao user
  def remember
    self.remember_token = User.new_token		#cria uma token nova. Sem usar o "self" iria criar uma variavel local em vez de usar o atributo que é o qu realmente queremos.
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #true se a token que é passada por parametro é igual ao digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end 
  
  # para esquecer um user
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end
