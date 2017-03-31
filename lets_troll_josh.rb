require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'fortune_gem'

Capybara.run_server            = false
Capybara.current_driver        = :selenium
Capybara.app_host              = 'https://responses.zenloop.com/web/surveys/'
josh_survey_to_troll_public_id = "Z1dGdmJmUktjaWxjU29pSEpFTGQ2cEJSTTdLM3ZUSGtHYzU4YVVJMFJFbz0%3D"
how_many_times_each_score      = 10

module LetsTrollJosh
  class Trolololo
    include Capybara::DSL

    def visit_survey_link(survey_public_id)
      visit("/#{survey_public_id}")
    end

    def respond_with_score(survey_public_id, score_value)
      visit_survey_link(survey_public_id)
      click_link(score_value)
      write_comment
      sleep 1
    end

    def write_comment
      fortune = FortuneGem.give_fortune({:max_length => 100})
      fill_in 'answer_response', with: fortune
      click_button "Submit"
    end
  end
end

troll = LetsTrollJosh::Trolololo.new

["1","2","3","4","5","6","7","8","9","10"].each do |score|
  how_many_times_each_score.times do |time|
    troll.respond_with_score(josh_survey_to_troll_public_id, score)
  end
end
