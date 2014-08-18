# Build.PL for Business-DK-FI

# $Id$

use Module::Build;
my $build = Module::Build->new(
    dist_author          => 'Jonas B. Nielsen, (jonasbn) <jonasbn@cpan.org>',
    module_name          => 'Business::DK::FI',
    dist_version_from    => 'lib/Business/DK/FI.pm',
    dist_abstract        => 'validation of Danish FI numbers',
    license              => 'artistic',
    create_makefile_pl   => 'traditional',
    create_readme        => 1,
    recursive_test_files => 1,
    requires             => {
        'Exporter'         => '0',    #core
        'Carp'             => '0',    #core
        'Class::InsideOut' => '0',
        'Params::Validate' => '0',
        'Readonly'         => '0',
        'Try::Tiny'        => '0',
        'perl'             => '5.005.03',
    },
    build_requires => {
        'Test::Exception'    => '0',
    },
    meta_merge => {
        resources => {
            homepage => 'http://logiclab.jira.com/wiki/display/BDKFI/Home',
            bugtracker =>
                'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-DK-FI',
            repository => 'https://github.com/jonasbn/bdkfi',
            ProjectChangelog => 'http://logiclab.jira.com/browse/BDKFI#selectedTab=com.atlassian.jira.plugin.system.project%3Achangelog-panel',
            ProjectSite => 'http://logicLAB.jira.com/browse/BDKFI',
            ProjectWiki => 'http://logiclab.jira.com/wiki/display/BDKFI/Home',
        }
    },

);
$build->create_build_script();
