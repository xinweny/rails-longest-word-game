class ApplicationController < ActionController::Base
  def add_score(score)
    if session['score'].nil?
      session['score'] = 0
    else
      session['score'] += score
    end
  end
end
