package Class::Business::DK::FI;

# $Id$

use strict;
use warnings;
use Class::InsideOut qw( private register id );
use Carp qw(croak);
use English qw(-no_match_vars);

use Business::DK::FI qw(validateFI);

private number => my %number;    # read-only accessor: number()

sub new {
    my ( $class, $number ) = @_;

    ## no critic (Variables::ProhibitUnusedVariables)
    my $self = \( my $scalar );

    bless $self, $class;

    register($self);

    if ($number) {
        $self->set_number($number);
    } else {
        croak 'You must provide a FI number';
    }

    return $self;
}

## no critic (Subroutines::RequireFinalReturn)
sub number { $number{ id $_[0] } }

sub get_number { $number{ id $_[0] } }

sub set_number {
    my ( $self, $unvalidated_fi ) = @_;

    my $rv = 0;

    if ($unvalidated_fi) {
        eval { $rv = validateFI($unvalidated_fi); 1; };

        if ( $EVAL_ERROR or not $rv ) {
            croak 'Invalid FI number parameter';

        } else {

            $number{ id $self } = $unvalidated_fi;

            return 1;
        }
    } else {
        croak 'You must provide a FI number';
    }
}

1;

__END__

=head1 NAME

Class::Business::DK::FI - class for Danish FI numbers

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 new

=head2 number

=head2 get_number

=head2 set_number

Takes a single argument. 16 digit FI number.

=head1 BUGS

Please report issues via CPAN RT:

  http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-DK-FI

or by sending mail to

  bug-Business-DK-FI@rt.cpan.org

=head1 SEE ALSO

=over

=item 

=back

=head1 AUTHOR

Jonas B. Nielsen, (jonasbn) - C<< <jonasbn@cpan.org> >>

=head1 COPYRIGHT

Business-DK-FI is (C) by Jonas B. Nielsen, (jonasbn) 2006

Business-DK-FI is released under the artistic license

The distribution is licensed under the Artistic License, as specified
by the Artistic file in the standard perl distribution
(http://www.perl.com/language/misc/Artistic.html).

=cut
