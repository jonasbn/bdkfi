package Business::DK::FI;

# $Id$

use strict;
use warnings;
use vars qw($VERSION @EXPORT_OK);
use Params::Validate qw(validate_pos SCALAR ARRAYREF);
use Readonly;
use base qw(Exporter);

$VERSION = '0.01';
@EXPORT_OK = qw(validate validateFI generate);

use constant MODULUS_OPERAND => 10;
use constant INVALID         => 0;
use constant VALID           => 1;

Readonly my @controlcifers => qw(1 2 1 2 1 2 1 2 1 2 1 2 1 2);
Readonly my $control_length => scalar @controlcifers;

sub validateFI {
    return validate(shift);
}

## no critic (Subroutines::RequireArgUnpacking)

sub validate {
    my ($fi_number) = @_;

    validate_pos( @_, { type => SCALAR, regex => qr/^\d{15}$/xsm } );

    my ($last_digit);
    ($fi_number, $last_digit) = $fi_number =~ m/^(\d{$control_length})(\d{1})$/;

    my $sum = _calculate_sum( $fi_number, \@controlcifers );
    my $checksum = _calculate_checksum($sum);

    if ( $checksum == $last_digit ) {
        return VALID;
    } else {
        return INVALID;
    }
}

sub _calculate_checksum {
    my ( $sum ) = @_;

    validate_pos( @_,
        { type => SCALAR, regex => qr/^\d+$/xsm },
    );
    
    return (10 - ($sum % MODULUS_OPERAND));
}

sub _calculate_sum {
    my ( $number, $controlcifers ) = @_;

    validate_pos( @_,
        { type => SCALAR, regex => qr/^\d+$/xsm },
        { type => ARRAYREF },
    );

    my $sum = 0;
    my @numbers = split //smx, $number;

    for ( my $i = 0; $i < scalar @numbers; $i++ ) {
        my $tmp = $numbers[$i] * $controlcifers->[$i];
        
        if ($tmp >= 10) {
            $sum += ($tmp - 9);
        } else {
            $sum += $tmp;
        }
    }
    return $sum;
}

sub generate {
    my ( $number ) = @_;

    validate_pos( @_,
        { type => SCALAR, regex => qr/^\d{1,$control_length}$/ },
    );

    $number = sprintf '%0'.$control_length.'d', $number;
    
    my $sum = _calculate_sum( $number, \@controlcifers );
    my $checksum = _calculate_checksum($sum);
    
    $number = $number . $checksum;
    
    return $number;
}

1;

__END__

=head1 NAME

Business::DK::FI - validation of Danish FI numbers

=head1 VERSION

The documentation describes version 0.01

=head1 SYNOPSIS

    use Business::DK::FI qw(validate validateFI generate);
    
    if (validate('026840149965328')) {
        print "026840149965328 is valid\n";
    }
    
    
    my $fi_number = generate(1);
    
    if ($fi_number eq '000000000000018') {
        print "we have a FI number\n";
    }
    

=head1 DESCRIPTION

FI numbers are numbers used on GIRO payment forms. These can be used to do
online payments in banks or at in physical banks or post offices.

The module currently only supports FI numbers in the following series:

=over

=item * 71

=item * 75

=back

=head1 METHODS

=head2 validate

Takes a single argument. 15 digit FI number. Returns true (1) or false (0)
indicating whether the provided parameter adheres to requirements.

=head2 validateFI

Less intrusive exported variation of L</validate>. It is actually L</validate>
which is wrapping L</validateFI>.

=head2 generate

Simple FI generation method. Takes an arbitrary number:

=over

=item * length between 1 and 14

=item * value between 1 and 99999999999999

=back

Returns a FI number

=head2 _calculate_checksum

=head2 _calculate_sum

=head1 BUGS

Please report issues via CPAN RT:

  http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-DK-FI

or by sending mail to

  bug-Business-DK-FI@rt.cpan.org

=head1 SEE ALSO

=over

=item * http://www.pbs.dk/

=back

=head1 AUTHOR

Jonas B. Nielsen, (jonasbn) - C<< <jonasbn@cpan.org> >>

=head1 COPYRIGHT

Business-DK-FI is (C) by Jonas B. Nielsen, (jonasbn) 2011

Business-DK-FI is released under the artistic license

The distribution is licensed under the Artistic License, as specified
by the Artistic file in the standard perl distribution
(http://www.perl.com/language/misc/Artistic.html).

=cut
