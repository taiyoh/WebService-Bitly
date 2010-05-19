use inc::Module::Install;
name 'WebService-Bitly';
all_from 'lib/WebService/Bitly.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
