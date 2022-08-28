class RequestPodcastController < AdminController
  skip_before_action :privileged
  layout "clean"
end
