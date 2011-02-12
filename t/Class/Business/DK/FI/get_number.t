#!/usr/bin/perl -w

# $Id$

use strict;
use warnings;
use Test::More tests => 1;

use Class::Business::DK::FI;

my $fi = Class::Business::DK::FI->new('0026840149965328');

is($fi->get_number(), '0026840149965328');
