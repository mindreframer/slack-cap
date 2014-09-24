module Slack
  module Cap

    # simple colorization
    class Colorize
      def self.colorize(text, color_code)
        "\e[#{color_code}m#{text}\e[0m"
      end

      def self.red(text)
        colorize(text, 31)
      end

      def self.green(text)
        colorize(text, 32)
      end

      def self.yellow(text)
        colorize(text, 33)
      end

      def pink(text)
        colorize(text, 35)
      end
    end
  end
end
