# $Id$

use strict;
use warnings;
use Test::More tests => 8;
use Test::Exception;

#Test 1
use_ok('Business::DK::FI', qw(validate));

#Test 2
ok(validate('0026840149965328'), 'Ok');

#Test 3
dies_ok {validate()} 'no arguments';

#Test 4
dies_ok {validate(123456789012345)} 'too short, 15';

#Test 5
dies_ok {validate(12345678901234567)} 'too long, 17';

#Test 6
dies_ok {validate('00268401A9965328')} 'unclean';

#Test 7
dies_ok {validate(0)} 'zero';

#Test 8
ok(! validate('0026840149965327'), 'error prone');