# frozen_string_literal: true

module FtcEvent
  class Qualification < Match
    attr_reader :event
    attr_reader :match

    def initialize(event, match)
      @event = event
      @match = match
    end

    def table_prefix
      'quals'
    end

    def short_name
      'Q-%i' % [match]
    end

    def short_identifier
      'Q%02i' % [match]
    end

    def long_name
      'Qualification Match %i' % [match]
    end

    def positions
      FtcEvent::ALLIANCES.product([1, 2]).map(&:join)
    end

    def teams
      positions.each_with_object({}) do |position, h|
        h[position] = Team.new(event, info[position])
      end
    end

    def each_team(alliance)
      return enum_for(:each_team, alliance) unless block_given?

      teams.each do |position, team|
        yield team if position.start_with?(alliance)
      end

      nil
    end

    def short_alliance_description(color)
      '%i & %i' % [
        teams["#{color}1"]&.number || 0,
        teams["#{color}2"]&.number || 0,
      ]
    end

    def long_alliance_description(color)
      '%s and %s' % [
        teams["#{color}1"].description,
        teams["#{color}2"].description,
      ]
    end
  end
end
