# frozen_string_literal: true

module FtcEvent
  class League
    attr_reader :event
    attr_reader :code

    def initialize(event, code)
      @event = event
      @code = code
    end

    def info
      event.db.query('SELECT * FROM leagueInfo WHERE code = ?', [code])&.first
    end

    def name
      info && info['name']
    end

    def teams
      result = event.db.query('SELECT team FROM leagueMembers WHERE code = ?', [code])
      result&.map { |row| row['team'] }
    end

    def each_team
      return enum_for(:each_team) unless block_given?

      teams.each do |number|
        yield event.team(number)
      end

      nil
    end
  end
end
