class Genre < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'こくご' },
    { id: 2, name: 'さんすう' },
    { id: 3, name: 'えいご' }
  ]

  include ActiveHash::Associations
  has_many :questions
  end