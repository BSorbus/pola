class Work < ApplicationRecord
  belongs_to :trackable, polymorphic: true, optional: true
  belongs_to :user, optional: true

  def action_name
    case action
    when 'create'
      'utworzył kartotekę'
    when 'update'
      'zmodyfikował kartotekę'
    when 'destroy'
      'usunął kartotekę'
    else
      'Error action value !'
    end  
  end

  def pretty_parameters
    JSON.pretty_generate(JSON.parse(self.parameters.gsub('":"', '": "')))
  end

end
