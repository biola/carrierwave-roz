# This is here only for testing

require 'rubygems'
require 'bundler'

Bundler.require :default, :development

require 'carrierwave/orm/activerecord'

Combustion.initialize! :active_record, :action_controller, :action_view
run Combustion::Application
