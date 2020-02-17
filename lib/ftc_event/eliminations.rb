# frozen_string_literal: true

module FtcEvent
  class Eliminations
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def name
      'Eliminations'
    end

    def match(match_number)
      Elimination.new(event, match_number)
    end

    def matches
      event.db.query('SELECT match FROM elims').map { |row| row['match'] }
    end

    def each_match
      return enum_for(:each_match) unless block_given?

      matches.each do |match_number|
        yield match(match_number)
      end

      nil
    end
  end
end
