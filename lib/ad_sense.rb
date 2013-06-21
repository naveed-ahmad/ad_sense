require 'active_support/core_ext/object'
require 'active_support'
require 'ad_sense/ad_sense'

module AdSense
  mattr_accessor :client_id
  mattr_accessor :default_ad_type
  mattr_accessor :default_ad_format
  mattr_accessor :default_query_for_search_ad

  class << self
    def config
      yield self
    end

    def default_ad_type
      @@default_ad_type ||= AdSense::AdType::TextImage
    end

    def default_ad_format
      @@default_ad_format ||= AdSense::AdFormat::LeaderBoard
    end

    def ad_client_id
      "ca-pub-#{client_id}"
    end

    def search_ad_client_id
      "pub-#{client_id}"
    end
  end
end
