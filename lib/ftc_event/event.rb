# frozen_string_literal: true

module FtcEvent
  class Event
    attr_reader :db

    def initialize(filename)
      @db = SQLite3::Database.new(filename, results_as_hash: true)
    end

    def config
      db.execute('SELECT key, value FROM config').each_with_object({}) do |row, h|
        h[row['key']] = row['value']
      end
    end

    def leagues
      db.execute('SELECT code FROM leagueInfo').map { |row| row['code'] }
    end

    def teams
      db.execute('SELECT number FROM teams').map { |row| row['number'] }
    end

    def code
      config['code']
    end

    def name
      config['name'].gsub(/FIRST Tech Challenge/, 'FTC').strip
    end

    def short_name
      code.upcase
    end

    def start
      Time.at(config['start'].to_f / 1000.0)
    end

    def end
      Time.at(config['end'].to_f / 1000.0)
    end

    def league(code = leagues.first)
      League.new(self, code) if code
    end

    def team(number)
      Team.new(self, number)
    end

    def each_team
      return enum_for(:each_team) unless block_given?

      teams.each do |number|
        yield team(number)
      end

      nil
    end

    def qualifications
      Qualifications.new(self)
    end

    def alliance(rank)
      Alliance.new(self, rank)
    end

    def eliminations
      Eliminations.new(self)
    end

    def phases
      [qualifications, eliminations]
    end

    def each_phase
      return enum_for(:each_phase) unless block_given?

      phases.each do |phase|
        yield phase unless phase.matches.empty?
      end

      nil
    end
  end
end
