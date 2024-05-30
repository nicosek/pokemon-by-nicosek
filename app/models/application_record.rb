class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def url
    Rails.application.routes.url_helpers.url_for(self)
  end
end
