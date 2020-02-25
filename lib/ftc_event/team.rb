# frozen_string_literal: true

module FtcEvent
  class Team
    attr_reader :event
    attr_reader :number

    def initialize(event, number)
      @event = event
      @number = number
    end

    def info
      event.db.query('SELECT * FROM teamInfo WHERE number = ?', [number])&.first
    end

    def name
      info && info['name'].strip
    end

    def school
      info && info['school'].strip
    end

    def city
      info && info['city'].strip
    end

    def state
      info && info['state'].strip
    end

    def country
      info && info['country'].strip
    end

    def location
      return unless info

      [
        city,
        state,
        country != 'USA' ? country : nil
      ].reject(&:nil?).join(', ')
    end

    def description
      "#{number} #{name}"
    end

    def full_description
      "#{description} from #{location}"
    end
  end
end
