use strict;
use Test::More qw/no_plan/;
use FindBin::libs;

use Data::Dumper qw/Dumper/;

use WebService::Bitly;

my $bitly = WebService::Bitly->new(
    login  => 'XXX login XXX',
    apiKey => 'XXX apiKey XXX',
    debug  => 1,
);

my $expanded = $bitly->expand({
    shortUrl => [qw#http://bit.ly/cjbKbl http://bit.ly/ce2AUt#]
});

ok($expanded, 'data returns');

print Dumper($expanded);
