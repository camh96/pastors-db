server 'app8.arise.net.nz', user: 'deploy', roles: %w{web app job}
server 'database2.arise.net.nz', user: 'deploy', roles: %w{db}

namespace :deploy do
  before :starting, :prouction
end
