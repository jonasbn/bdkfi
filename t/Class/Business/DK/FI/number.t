#!/usr/bin/perl -w

# $Id$

use strict;
use warnings;
use Test::More tests => 1;
use Test::Exception;

use Class::Business::DK::FI;

my $fi;

$fi = Class::Business::DK::FI->new('0026840149965328');

is($fi->number(), '0026840149965328');
