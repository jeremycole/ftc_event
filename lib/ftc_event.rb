# frozen_string_literal: true

module FtcEvent
  ALLIANCES = %w[red blue].freeze
end

require 'sqlite3'

require 'ftc_event/event'
require 'ftc_event/league'
require 'ftc_event/team'
require 'ftc_event/match'
require 'ftc_event/qualifications'
require 'ftc_event/qualification'
require 'ftc_event/alliance'
require 'ftc_event/eliminations'
require 'ftc_event/elimination'
