test_name 'PA-3114: Use facter-ng on all platforms' do

  tag 'audit:low',
      'audit:acceptance'

  require 'puppet/acceptance/common_utils'

  teardown do
    on agent, puppet('setconfig facterng false')
  end

  agents.each do |agent|
    step "test puppet facts with facter-ng'" do
      on agent, puppet('setconfig facterng true')
      on agent, puppet('facts'), :acceptable_exit_codes => [0] do
        facter_major_version = stdout.chomp.each{|line| line.match(/\s[0-9]]/).to_i if line.match?(/facterversion/)}
        assert_match(facter_major_version, 4, "puppet failed to change cfacter to facter-ng")
      end
    end
  end
end

