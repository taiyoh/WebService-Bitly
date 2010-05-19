use Test::More qw/no_plan/;
use FindBin::libs;

use_ok('WebService::Bitly');

do {
    local $@;
    eval { WebService::Bitly->new };
    ok($@, 'required params');
};

do {
    local $@;
    eval { WebService::Bitly->new(login => 'xxxx') };
    ok($@, 'required params : apiKey');
};

do {
    local $@;
    eval { WebService::Bitly->new(apiKey => 'aaabbb') };
    ok($@, 'required params : login');
};

my $bitly = WebService::Bitly->new(
    login  => 'xxxx',
    apiKey => 'aaabbbdddccc'
);

isa_ok($bitly, 'WebService::Bitly');
