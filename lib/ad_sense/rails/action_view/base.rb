module AdSense
  module Rails
    module ActionView
      module Base
        def ad_slot_tag(ad_slot = nil, options = {})
          adsense_opts  = get_ad_options_from_hash(options.merge!(ad_slot: ad_slot), false)
          wrapper_class = get_classes_for_ad_wrapper(options)
          adsense_opts  = get_ad_script_from_hash(adsense_opts)

          generate_ad_tag wrapper_class, adsense_opts
        end

        def ad_search_tag(options)
          # based on https://developers.google.com/custom-search-ads/docs/code-generator
          script = <<-SCRIPT.strip_heredoc
                 var pageOptions = {
                   'pubId': '#{AdSense.search_ad_client_id}',
                   'query': '#{AdSense.default_query_for_search_ad}',
                   'hl': 'en'
                 };

                var adblock1 = {
                  'container': '#{options[:add_container_id]}',
                  'width': '#{options[:add_container_width]}'
                };
                new google.ads.search.Ads(pageOptions, adblock1);
          SCRIPT

          content_tag :div, class: "search_ad_wrapper #{options[:wrapper_class]}" do
            [content_tag(:div, '', id: options[:add_container_id]),
             javascript_include_tag('http://www.google.com/adsense/search/ads.js'),
             javascript_tag { script }].join('')
          end.html_safe
        end

        def ad_link_tag(ad_slot, options = {})
          adsense_opts  = get_ad_options_from_hash(options.merge(ad_slot: ad_slot), true)
          wrapper_class = get_classes_for_ad_wrapper(adsense_opts)
          adsense_opts  = get_ad_script_from_hash(adsense_opts)

          generate_ad_tag wrapper_class, adsense_opts
        end

        protected
        def get_ad_options_from_hash(options, is_links_ad)
          ad_format = options[:format] || AdSense.default_ad_format
          width, height = AdSense::AdFormat.get_dimension(ad_format)
          ad_type = nil

          if options[:ad_slot].blank?
            add_type = options[:ad_type] || AdSense.default_ad_type
            ad_format_str = AdSense::AdFormat.ad_format_string(ad_format, is_links_ad)
          end
       
          options.merge! ad_type: ad_type, ad_format: ad_format
       
          adsense_opts = {
              google_ad_client: AdSense.client_id,
              google_ad_slot:   options[:ad_slot],
              google_ad_width:  width,
              google_ad_height: height,
              google_ad_format: ad_format_str,
              google_ad_type:   add_type
          }
        end

        def get_classes_for_ad_wrapper(options)
          wrapper_class = "ad_sense_slot #{options[:wrapper_class]}"
          if options[:ad_slot].blank?
            wrapper_class << "#{options[:add_type]}_ad"
          end
          wrapper_class
        end

        def get_ad_script_from_hash(options)
          options.map do |k, v|
            v = v.is_a?(String) ? "\"#{v}\"" : v
            "#{k} = #{v};" unless v.blank?
          end.compact.sort.join("\n")
        end

        def generate_ad_tag(wrapper_class, adsense_opts)
          # based on http://www.adsense-generator.com/
          content_tag :div, class: wrapper_class do
            [javascript_tag(adsense_opts), javascript_include_tag('http://pagead2.googlesyndication.com/pagead/show_ads.js')].join('')
          end.html_safe
        end
      end
    end
  end
end
