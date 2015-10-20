Gem::Specification.new do |s|
  s.name        = 'tor257'
  s.version     = '0.1'
  s.date        = Time.now.getgm.to_s.split.first
  s.summary     = File.read("CHANGELOG").match(/^v[^\n]+\n((\t[^\n]+\n)+)/m)[1].split("\t").join
  s.description = 'An experimental encryption algorithm'
  s.authors     = ['poulet_a']
  s.email       = ['poulet_a@epitech.eu']
  s.files       = %w(
lib/tor257.rb
lib/tor257/core.rb

README.md
CHANGELOG

tor257.gemspec

bin/tor257
)
  s.executables = %w(
tor257
)
  s.homepage    = 'https://github.com/pouleta/tor257'
  s.license     = 'GNU/GPLv3'

  s.cert_chain  = ['certs/nephos.pem']
  s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $0 =~ /gem\z/

  s.add_dependency 'nomorebeer', '~> 1.1'

end
