# frozen_string_literal: true

module FtcEvent
  class Match
    attr_reader :event
    attr_reader :match

    def initialize(event, match)
      @event = event
      @match = match
    end

    def table_prefix
      raise 'Abstract method not implemented'
    end

    def one_row_from_table(table, match)
      result = event.db.query("SELECT * FROM #{table_prefix}#{table} WHERE match = ?", [match])
      result&.first
    end

    def info
      one_row_from_table('', match)
    end

    def data
      one_row_from_table('Data', match)
    end

    def results
      one_row_from_table('Results', match)
    end

    def game_specific
      one_row_from_table('GameSpecific', match)
    end

    def short_name
      raise 'Abstract method not implemented'
    end

    def short_identifier
      raise 'Abstract method not implemented'
    end

    def long_name
      raise 'Abstract method not implemented'
    end

    def positions
      raise 'Abstract method not implemented'
    end

    def teams
      raise 'Abstract method not implemented'
    end

    def each_team(_alliance)
      raise 'Abstract method not implemented'
    end

    def short_alliance_description(_color)
      raise 'Abstract method not implemented'
    end

    def long_alliance_description(_color)
      raise 'Abstract method not implemented'
    end

    def short_alliances_description
      '%s vs. %s' % [
        short_alliance_description('red'),
        short_alliance_description('blue'),
      ]
    end

    def long_alliances_description
      '%s vs. %s' % [
        long_alliance_description('red'),
        long_alliance_description('blue'),
      ]
    end

    def short_description
      "#{short_name}: #{short_alliances_description}"
    end

    def long_description
      "#{long_name}: #{long_alliances_description}"
    end

    def other_alliance(alliance)
      return unless FtcEvent::ALLIANCES.include?(alliance)

      FtcEvent::ALLIANCES.reject { |x| x == alliance }.first
    end

    def penalties_by(alliance)
      results["#{alliance}PenaltyCommitted"]
    end

    def points_for(alliance)
      results["#{alliance}Score"]
    end

    def score_for(alliance)
      points_for(alliance) + penalties_by(other_alliance(alliance))
    end

    def winner
      red  = score_for('red')
      blue = score_for('blue')

      if red > blue
        'red'
      elsif blue > red
        'blue'
      else
        'tie'
      end
    end

    def win_for(alliance)
      case winner
      when 'tie'
        'tie'
      when alliance
        'win'
      when other_alliance(alliance)
        'loss'
      end
    end

    def result_for(alliance)
      return unless ALLIANCES.include?(alliance)

      from_penalties = penalties_by(other_alliance(alliance))
      '%i points [%s penalties] (%s)' % [
        score_for(alliance),
        from_penalties.zero? ? 'no' : "#{from_penalties} from",
        win_for(alliance),
      ]
    end

    def result
      "Red #{result_for('red')}, Blue #{result_for('blue')}"
    end

    def started
      Time.at(data['start'].to_f / 1000.0)
    end

    def scheduled
      Time.at(data['scheduleStart'].to_f / 1000.0)
    end

    def posted
      Time.at(data['postedTime'].to_f / 1000.0)
    end
  end
end
