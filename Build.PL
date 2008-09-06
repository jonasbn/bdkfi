# Build.PL for Business-DK-FI

# $Id$

use Module::Build;
my $build = Module::Build->new(
	dist_author        => 'Jonas B. Nielsen, (jonasbn) <jonasbn@cpan.org>',
	module_name        => 'Business::DK::FI',
	dist_version_from  => 'lib/Business/DK/FI.pm',
	license            => '$LICENSE',
	create_makefile_pl => 'passthrough',
);
$build->create_build_script();
