module AdSense
  module AdFormat
    # visit for available formats/sizes
    #http://support.google.com/adsense/bin/answer.py?hl=en&answer=185666
    LargeLeaderBoard = "970x90"
    MediumRectangle = "300x250"
    LargeSkyscraper = "300x600"
    SmallRrectangle = "180x150"
    LargeRectangle = "336x280"
    VerticalBanner = "120x240"
    WideSkyscraper = "160x600"
    MobileBanner = "320x50"
    LeaderBoard = "728x90"
    SmallSquare = "200x200"
    Skyscraper = "120x600"
    HalfBanner = "234x60"
    Banner = "468x60"
    Square = "250x250"
    Button = "125x125"

    class << self
      def get_dimension(format)
        format_value = get_format_value(format)
        format_value.split('x').map(&:to_i)
      rescue NameError
        []
      end

      def ad_format_string(format, is_links_ad = false)
        format_value = get_format_value(format)

        if format_value.present?
          prepend_string = is_links_ad ? '_0ads_al' : '_as'
          "#{format_value}#{prepend_string}"
        end
      end

      def available_formats
        AdFormat.constants.map { |format| format.to_s.underscore.to_sym }
      end

      protected
      def get_format_value(format)
        if format.is_a?(String) && format.include?('x')
          format
        else
          AdFormat.const_get format.to_s.camelize
        end
      rescue
        ''
      end
    end
  end
end
