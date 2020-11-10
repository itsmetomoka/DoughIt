# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = Rails.env.to_sym
# 環境を設定
set :environment, rails_env
# ログの出力先ファイルを設定
set :output, 'log/cron.log'
every 2.minutes do
  begin
  	runner 'Batch::EditLessons.edit_lessons', :environment => 'production'

  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

# bundle exec rails runner Batch::EditLessons.edit_lessons
# bundle exec whenever
# bundle exec whenever --update-crontab
# crontab -l
# sudo systemctl start crond
# sudo systemctl stop crond
