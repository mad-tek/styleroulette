class Style < ActiveRecord::Base
  attr_accessible :name
  def self.selected(selected)
      if selected
          where('name LIKE ?', "%#{selected}%")
          return selected
      else
          scoped
      end
  end
end
