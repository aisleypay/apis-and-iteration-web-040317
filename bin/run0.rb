#!/usr/bin/env ruby

require_relative "../lib/api_communicator0.rb"
require_relative "../lib/command_line_interface0.rb"

subject = get_subject_from_user
specific_subject = get_subject_specific_from_user(subject)

show_character_movies(subject, specific_subject)
