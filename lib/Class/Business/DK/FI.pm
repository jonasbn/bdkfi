package Class::Business::DK::FI;

# $Id$

use strict;
use warnings;
use Class::InsideOut qw( private register id );
use Carp qw(croak);
use English qw(-no_match_vars);

use Business::DK::FI qw(validateFI);

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

1;
