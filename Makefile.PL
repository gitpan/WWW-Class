use inc::Module::Install;

name     'WWW-Class';
all_from 'lib/WWW/Class.pm';
author   q{Brad Haywood <brad@geeksware.net>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

