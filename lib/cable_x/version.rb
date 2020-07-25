# frozen_string_literal: true

module CableX
  VERSION = File.read('Version').split("\n").first.gsub('v', '')
end
