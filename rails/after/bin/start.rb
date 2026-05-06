#!/usr/bin/env ruby
# Distroless-friendly launcher: no shell, no bundle binary, just ruby.
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
require "bundler/setup"
require "puma/cli"

Puma::CLI.new(["-C", "config/puma.rb"]).run
