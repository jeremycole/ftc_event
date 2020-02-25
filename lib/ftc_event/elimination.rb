# frozen_string_literal: true

module FtcEvent
  class Elimination < Match
    attr_reader :event
    attr_reader :match

    def initialize(event, match)
      @event = event
      @match = match
    end

    def table_prefix
      'elims'
    end

    def short_name
      case match
      when 1, 3, 5
        'SF1-%i' % [(match + 1) / 2]
      when 2, 4, 6
        'SF2-%i' % [(match + 0) / 2]
      when 7
        'F-1'
      when 9
        'F-2'
      end
    end

    def short_identifier
      short_name.gsub(/-/, '')
    end

    def long_name
      case match
      when 1, 3, 5
        'Semifinal 1 Match %i' % [(match + 1) / 2]
      when 2, 4, 6
        'Semifinal 2 Match %i' % [(match + 0) / 2]
      when 7
        'Final Match 1'
      when 9
        'Final Match 2'
      end
    end

    def positions
      FtcEvent::ALLIANCES
    end

    def alliances
      positions.each_with_object({}) do |position, h|
        h[position] = Alliance.new(event, info[position])
      end
    end

    def each_team(alliance)
      return enum_for(:each_team, alliance) unless block_given?

      alliances[alliance].each_team do |team|
        yield team
      end

      nil
    end

    def short_alliance_description(color)
      alliances[color].short_description
    end

    def long_alliance_description(color)
      alliances[color].long_description
    end
  end
end
