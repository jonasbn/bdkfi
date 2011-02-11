# $Id$

use strict;
use warnings;
use Test::More tests => 5;
use Test::Exception;

#Test 1
use_ok('Business::DK::FI', qw(generate validate));

#Test 2
ok(validate(generate(1)), 'Ok');

ok(validate(generate(123456789012345)), 'Ok');

dies_ok { validate(generate(1234567890123456)) } 'too long, 16'; 
         
dies_ok { generate() } 'no params';