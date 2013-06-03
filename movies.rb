#!/usr/bin/env ruby

require_relative 'bootstrap_ar'
require 'faraday'
require 'pp'
include MoviesController
database = ENV['FP_ENV'] || 'development'
connect_to database


login_screen

