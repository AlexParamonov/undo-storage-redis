require 'rspec'
require_relative "support/ci_helper"
require 'undo/storage/redis'

$: << File.expand_path('../lib', File.dirname(__FILE__))
