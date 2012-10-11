#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Support
  class Engine < Rails::Engine
  	isolate_namespace Support

    initializer "support" do
      ActionView::Base.send(:include, Support::TableHelper)
      ActionView::Base.send(:include, Support::FormHelper)

      ActionController::Base.send(:include, Support::ParamsHelper)

      ActiveRecord::Base.send(:include, Support::ModelHelper)
    end
  end
end
