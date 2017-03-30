class User < ApplicationRecord
  validates(:first_name, { presence: true })
  validates(:last_name, { presence: true })
  validates(:email, { presence: true })

  def self.search(search_term)
    where(['first_name LIKE ? OR last_name LIKE ? OR email LIKE ?', "#{search_term}", "#{search_term}", "#{search_term}"])
  end
end
