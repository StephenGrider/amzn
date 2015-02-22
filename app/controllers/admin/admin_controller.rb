module Admin
  class AdminController < ApplicationController
    before_filter :require_admin

    def index
      @delayed_jobs = Delayed::Job.all
    end

    def fetch
      fetcher = Services::Popshops::ItemFetcher.new(page: 1, category: params[:category])
      count = fetcher.do_request

      flash[:notice] = "Added #{count} additional items"

      redirect_to '/admin'
    end
  end
end
