test_name 'PA-3114: Use facter-ng on all platform' do

  tag 'audit:low',
      'audit:acceptance'

  require 'puppet/acceptance/common_utils'

  agents.each do |agent|
    step "test facter-ng command'"
    facter_ng_dir = String.new
    on agent, "#{gem_command(agent)} which facter-ng'", :acceptable_exit_codes => [0] do
      facter_ng_dir = stdout.chomp
    end
    facter_ng_dir = facter_ng_dir.match(/\.*facter-ng-[0-9]+\.[0-9]+\.[0-9]+/).to_s

    on agent, "#{facter_ng_dir}/bin/facter-ng", :acceptable_exit_codes => [0]
  end
end
