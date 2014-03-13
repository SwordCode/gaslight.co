class RobotsController < ApplicationController

  def index
    robots = Rails.env.production? ? allowed : disallowed
    render text: robots
  end

  private

  def allowed
    <<-EOF.strip_heredoc
      # User-Agent: *
      # Disallow: /
    EOF
  end

  def disallowed
    <<-EOF.strip_heredoc
      User-Agent: *
      Disallow: /
    EOF
  end
end

