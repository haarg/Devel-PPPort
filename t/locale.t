################################################################################
#
#            !!!!!   Do NOT edit this file directly!   !!!!!
#
#            Edit mktests.PL and/or parts/inc/locale instead.
#
#  This file was automatically generated from the definition files in the
#  parts/inc/ subdirectory by mktests.PL. To learn more about how all this
#  works, please read the F<HACKERS> file that came with this distribution.
#
################################################################################

BEGIN {
  if ($ENV{'PERL_CORE'}) {
    chdir 't' if -d 't';
    @INC = ('../lib', '../ext/Devel-PPPort/t', '../ext/Devel-PPPort/parts/inc') if -d '../lib' && -d '../ext';
    require Config; import Config;
    use vars '%Config';
    if (" $Config{'extensions'} " !~ m[ Devel/PPPort ]) {
      print "1..0 # Skip -- Perl configured without Devel::PPPort module\n";
      exit 0;
    }
  }
  else {
    unshift @INC, 't', 'parts/inc';
  }

  sub load {
    eval "use Test";
    require 'testutil.pl' if $@;
    require 'inctools';
  }

  if (1) {
    load();
    plan(tests => 1);
  }
}

use Devel::PPPort;
use strict;
BEGIN { $^W = 1; }

package Devel::PPPort;
use vars '@ISA';
require DynaLoader;
@ISA = qw(DynaLoader);
bootstrap Devel::PPPort;

package main;

use Config;

  # We don't know for sure that we are in the global locale for testing.  But
  # if this is unthreaded, it almost certainly is.  But Configure can be called
  # to force POSIX locales on unthreaded systems.  If this becomes a problem
  # this check could be beefed up.
  if ($Config{usethreads}) {
    ok(1);
}
else {
    ok(&Devel::PPPort::sync_locale());
}

