package Business::DK::FI;

# $Id$

use strict;
use warnings;
use vars qw($VERSION @EXPORT_OK @ISA);
use Params::Validate qw(validate_pos SCALAR ARRAYREF);
use Readonly;

$VERSION = '0.01';
@EXPORT_OK = qw(validate validateFI generate);
@ISA = qw(Exporter);

use constant MODULUS_OPERAND => 10;
use constant INVALID         => 0;
use constant VALID           => 1;

Readonly my @controlcifers => qw(1 2 1 2 1 2 1 2 1 2 1 2 1 2);

sub validateFI {
    return validate(shift);
}

sub validate {
    my ($fi_number) = @_;

    validate_pos( @_, { type => SCALAR, regex => qr/^\d{16}$/ } );

    my ($first_digit, $last_digit);
    ($first_digit, $fi_number, $last_digit) = $fi_number =~ m/^(\d{1})(\d{14})(\d{1})$/;

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
        { type => SCALAR, regex => qr/^\d+$/ },
    );
    
    return (10 - ($sum % MODULUS_OPERAND));
}

sub _calculate_sum {
    my ( $number, $controlcifers ) = @_;

    validate_pos( @_,
        { type => SCALAR, regex => qr/^\d+$/ },
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
        { type => SCALAR, regex => qr/^\d{1,15}$/ },
    );
    my ($first_digit);
    
    ($first_digit, $number) = $number =~ m/^(\d{1}(?=\d*))(\d*)$/;

    if ($number) {
        $number = sprintf '%014d', $number;
    } else {
        $number = sprintf '%014d', $first_digit;
    }
    
    my $sum = _calculate_sum( $number, \@controlcifers );
    my $checksum = _calculate_checksum($sum);
    
    $number = $first_digit . $number . $checksum;
    
    return $number;
}

1;

__END__

=head1 NAME

Business::DK::FI - validation of Danish FI numbers

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 validate

Takes a single argument. 16 digit FI number.

=head2 validateFI

Less intrusive exported variation of L</validate>. It is actually L</validate>
which is wrapping L</validateFI>.

=head2 generate

Simple FI generation method.

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
