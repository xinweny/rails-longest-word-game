class ApplicationController < ActionController::Base
  def add_score(score = 0)
    if session['score'].nil?
      session['score'] = score
    else
      session['score'] += score
    end
  end
end
