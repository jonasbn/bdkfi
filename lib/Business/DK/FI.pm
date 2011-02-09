package Business::DK::FI;

# $Id$

use strict;
use warnings;
use vars qw($VERSION @EXPORT_OK @ISA);
use Params::Validate qw(validate_pos SCALAR);
use Readonly;
use Business::DK::CVR qw(_calculate_sum);

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

    my $sum = _calculate_sum( $fi_number, \@controlcifers );

    if ( $sum % MODULUS_OPERAND ) {
        return INVALID;
    } else {
        return VALID;
    }
}

sub generate {
    
}

1;

__END__

=head1 NAME

Business::DK::FI - validation of Danish FI numbers

=head1 SYNOPSIS

=head1 ABSTRACT

=head1 DESCRIPTION

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
