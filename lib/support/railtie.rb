require 'rails'
require 'support/table_helper'
require 'support/params_helper'
require 'support/form_helper'

module Support
  class Railtie < Rails::Railtie
    initializer 'support' do
      ActionView::Base.send(:include, Support::TableHelper)
      ActionView::Base.send(:include, Support::FormHelper)

      ActionController::Base.send(:include, Support::ParamsHelper)
    end
  end
end
