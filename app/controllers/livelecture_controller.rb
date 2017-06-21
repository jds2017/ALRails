class LivelectureController < ApplicationController
  def start
    render "teacher"
  end

  def join
    render "student"
  end
end
