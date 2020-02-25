# frozen_string_literal: true

module FtcEvent
  class Alliance
    attr_reader :event
    attr_reader :rank

    def initialize(event, rank)
      @event = event
      @rank = rank
    end

    def info
      event.db.query('SELECT * FROM alliances WHERE rank = ?', [rank])&.first
    end

    def teams
      [1, 2, 3].map { |n| info["team#{n}"] }.reject(&:zero?)
    end

    def each_team
      return enum_for(:each_team) unless block_given?

      teams.each do |team_number|
        yield event.team(team_number)
      end

      nil
    end

    def short_team_list
      each_team.map(&:number).join('/')
    end

    def long_team_list
      each_team.map(&:description).join(' and ')
    end

    def short_description
      "##{rank} #{short_team_list}"
    end

    def long_description
      "##{rank} #{long_team_list}"
    end
  end
end
