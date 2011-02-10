# Courtesy of Jeffrey Ryan Thalhammer
# http://search.cpan.org/~thaljef/Test-Perl-Critic/lib/Test/Perl/Critic.pm

# The severity parameter interpretation was added by jonasbn
# See: http://logiclab.jira.com/wiki/display/OPEN/Test-Perl-Critic

# $Id: critic.t 1781 2010-12-16 13:15:53Z jonasbn $

# $HeadURL: https://subversion.dkhm/svn/scripts/DKHM-AAA/trunk/t/critic.t $

use strict;
use warnings;
use File::Spec;
use Test::More;
use English qw(-no_match_vars);
use Test::Perl::Critic;

if ( not $ENV{TEST_CRITIC} ) {
    my $msg = 'set TEST_CRITIC to enable this test';
    plan( skip_all => $msg );
}

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );

Test::Perl::Critic->import(
    -profile => $rcfile,
    -severity => $ENV{TEST_CRITIC} ? $ENV{TEST_CRITIC} : 5
);

all_critic_ok();

__END__

=pod

=head1 NAME

critic.t - a unit test from Test::Perl::Critic

=head1 DESCRIPTION

This test checks your code against Perl::Critic, which is a implementation of
a subset of the Perl Best Practices.

It's severity can be controlled using the severity parameter in the use
statement. 1 being the lowest and 5 being the highests.

Setting the severity lower, indicates level of strictness

Over the following range:

gentle, stern, harsh, cruel, brutal

So gentle would only catch severity 5 issues.

Since this tests tests all packages in your distribution, perlcritic
commandline tool can be used in addition.

L<perlcritic>

=cut
