#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
