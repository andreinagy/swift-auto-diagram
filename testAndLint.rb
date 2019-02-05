#!/usr/bin/env ruby

puts 'Linting...'
puts `rubocop -a`

puts 'Implement diff between output and reference output...'
