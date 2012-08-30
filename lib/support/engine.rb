module Support
  class Engine < Rails::Engine
  	isolate_namespace Support

    initializer "support" do
      ActionView::Base.send(:include, Support::TableHelper)
      ActionView::Base.send(:include, Support::FormHelper)

      ActionController::Base.send(:include, Support::ParamsHelper)
    end
  end
end
