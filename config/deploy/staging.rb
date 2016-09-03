server 'staging2.arise.net.nz', user: 'deploy', roles: %w{web app db job}

namespace :deploy do
  before :starting, :staging
end
