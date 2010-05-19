use strict;
use Test::More qw/no_plan/;
use FindBin::libs;
use WebService::Bitly;

my $bitly = WebService::Bitly->new(
    login  => 'XXX login XXX',
    apiKey => 'XXX apiKey XXX',
    debug  => 1,
);

my $url = 'http://api.bit.ly/v3/bitly_pro_domain?domain=nyti.ms&apiKey=R_27e5741aaa6a5&login=basixow&format=txt';

my $shorten = $bitly->shorten($url);

ok($shorten, 'url returns');
like($shorten, qr/^http:\/\/bit\.ly/, 'url =~ /^http:\/\/bit\.ly/');
#ok($shorten, 'url returns');

my $shorten2 = $bitly->shorten($url, 1);

is(ref($shorten2), 'HASH', 'return HASH reference');
like($shorten2->{url}, qr/^http:\/\/bit\.ly/, 'hashed url =~ /^http:\/\/bit\.ly/');

