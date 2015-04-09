namespace :fetcher do
  desc "Create a cron job to periodically fetch new items"
  task start: :environment do
    Services::FetchManager.new.fetch
  end
end
