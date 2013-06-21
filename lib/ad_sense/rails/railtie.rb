require 'rails'
module AdSense
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'AdSense Helper' do
        ::ActionView::Base.send :include, AdSense::Rails::ActionView::Base
      end
    end
  end
end
