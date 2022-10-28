class PingTasksController < ApplicationController
  def task1
    `RAILS_ENV=#{Rails.env} bundle exec rails runner lib/batch/contributor_commit_collector.rb`

    head :no_content
  end

  def health_check
    `RAILS_ENV=#{Rails.env} bundle exec rake health_check --trace`

    head :no_content
  end

  private

  def from_new_relic?
    return head :no_content if params[:new_relic].blank? || params[:new_relic].to_s != 'true'
  end
end
