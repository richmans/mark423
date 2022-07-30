class RequestPodcastController < ApplicationController
  skip_before_action :privileged
  layout "clean"
end
