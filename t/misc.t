################################################################################
#
#            !!!!!   Do NOT edit this file directly!   !!!!!
#
#            Edit mktests.PL and/or parts/inc/misc instead.
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

  if (26826) {
    load();
    plan(tests => 26826);
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

use vars qw($my_sv @my_av %my_hv);

ok(&Devel::PPPort::boolSV(1));
ok(!&Devel::PPPort::boolSV(0));

$_ = "Fred";
ok(&Devel::PPPort::DEFSV(), "Fred");
ok(&Devel::PPPort::UNDERBAR(), "Fred");

if (ivers($]) >= ivers(5.9.2) && ivers($]) < ivers(5.23)) {
  eval q{
    no warnings "deprecated";
    no if $^V > v5.17.9, warnings => "experimental::lexical_topic";
    my $_ = "Tony";
    ok(&Devel::PPPort::DEFSV(), "Fred");
    ok(&Devel::PPPort::UNDERBAR(), "Tony");
  };
}
else {
  ok(1);
  ok(1);
}

my @r = &Devel::PPPort::DEFSV_modify();

ok(@r == 3);
ok($r[0], 'Fred');
ok($r[1], 'DEFSV');
ok($r[2], 'Fred');

ok(&Devel::PPPort::DEFSV(), "Fred");

eval { 1 };
ok(!&Devel::PPPort::ERRSV());
eval { cannot_call_this_one() };
ok(&Devel::PPPort::ERRSV());

ok(&Devel::PPPort::gv_stashpvn('Devel::PPPort', 0));
ok(!&Devel::PPPort::gv_stashpvn('does::not::exist', 0));
ok(&Devel::PPPort::gv_stashpvn('does::not::exist', 1));

$my_sv = 1;
ok(&Devel::PPPort::get_sv('my_sv', 0));
ok(!&Devel::PPPort::get_sv('not_my_sv', 0));
ok(&Devel::PPPort::get_sv('not_my_sv', 1));

@my_av = (1);
ok(&Devel::PPPort::get_av('my_av', 0));
ok(!&Devel::PPPort::get_av('not_my_av', 0));
ok(&Devel::PPPort::get_av('not_my_av', 1));

%my_hv = (a=>1);
ok(&Devel::PPPort::get_hv('my_hv', 0));
ok(!&Devel::PPPort::get_hv('not_my_hv', 0));
ok(&Devel::PPPort::get_hv('not_my_hv', 1));

sub my_cv { 1 };
ok(&Devel::PPPort::get_cv('my_cv', 0));
ok(!&Devel::PPPort::get_cv('not_my_cv', 0));
ok(&Devel::PPPort::get_cv('not_my_cv', 1));

ok(Devel::PPPort::dXSTARG(42), 43);
ok(Devel::PPPort::dAXMARK(4711), 4710);

ok(Devel::PPPort::prepush(), 42);

ok(join(':', Devel::PPPort::xsreturn(0)), 'test1');
ok(join(':', Devel::PPPort::xsreturn(1)), 'test1:test2');

ok(Devel::PPPort::PERL_ABS(42), 42);
ok(Devel::PPPort::PERL_ABS(-13), 13);

ok(Devel::PPPort::SVf(42), ivers($]) >= ivers(5.4) ? '[42]' : '42');
ok(Devel::PPPort::SVf('abc'), ivers($]) >= ivers(5.4) ? '[abc]' : 'abc');

ok(&Devel::PPPort::Perl_ppaddr_t("FOO"), "foo");

ok(&Devel::PPPort::ptrtests(), 63);

ok(&Devel::PPPort::OpSIBLING_tests(), 0);

if (ivers($]) >= ivers(5.9)) {
  eval q{
    ok(&Devel::PPPort::check_HeUTF8("hello"), "norm");
    ok(&Devel::PPPort::check_HeUTF8("\N{U+263a}"), "utf8");
  };
} else {
  ok(1, 1);
  ok(1, 1);
}

@r = &Devel::PPPort::check_c_array();
ok($r[0], 4);
ok($r[1], "13");

ok(!Devel::PPPort::SvRXOK(""));
ok(!Devel::PPPort::SvRXOK(bless [], "Regexp"));

if (ivers($]) < ivers(5.5)) {
        skip 'no qr// objects in this perl', 0;
        skip 'no qr// objects in this perl', 0;
} else {
        my $qr = eval 'qr/./';
        ok(Devel::PPPort::SvRXOK($qr));
        ok(Devel::PPPort::SvRXOK(bless $qr, "Surprise"));
}

ok( Devel::PPPort::NATIVE_TO_LATIN1(0xB6) == 0xB6);
ok( Devel::PPPort::NATIVE_TO_LATIN1(0x1) == 0x1);
ok( Devel::PPPort::NATIVE_TO_LATIN1(ord("A")) == 0x41);
ok( Devel::PPPort::NATIVE_TO_LATIN1(ord("0")) == 0x30);

ok( Devel::PPPort::LATIN1_TO_NATIVE(0xB6) == 0xB6);
if (ord("A") == 65) {
    ok( Devel::PPPort::LATIN1_TO_NATIVE(0x41) == 0x41);
    ok( Devel::PPPort::LATIN1_TO_NATIVE(0x30) == 0x30);
}
else {
    ok( Devel::PPPort::LATIN1_TO_NATIVE(0x41) == 0xC1);
    ok( Devel::PPPort::LATIN1_TO_NATIVE(0x30) == 0xF0);
}

ok(  Devel::PPPort::isALNUMC_L1(ord("5")));
ok(  Devel::PPPort::isALNUMC_L1(0xFC));
ok(! Devel::PPPort::isALNUMC_L1(0xB6));

ok(  Devel::PPPort::isOCTAL(ord("7")));
ok(! Devel::PPPort::isOCTAL(ord("8")));

ok(  Devel::PPPort::isOCTAL_A(ord("0")));
ok(! Devel::PPPort::isOCTAL_A(ord("9")));

ok(  Devel::PPPort::isOCTAL_L1(ord("2")));
ok(! Devel::PPPort::isOCTAL_L1(ord("8")));

my $way_too_early_msg = 'UTF-8 not implemented on this perl';

# For the other properties, we test every code point from 0.255, and a
# smattering of higher ones.  First populate a hash with keys like '65:ALPHA'
# to indicate that the code point there is alphabetic
my $i;
my %types;
for $i (0x41..0x5A, 0x61..0x7A, 0xAA, 0xB5, 0xBA, 0xC0..0xD6, 0xD8..0xF6,
        0xF8..0x101)
{
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:ALPHA"} = 1;
    $types{"$native:ALPHANUMERIC"} = 1;
    $types{"$native:IDFIRST"} = 1;
    $types{"$native:IDCONT"} = 1;
    $types{"$native:PRINT"} = 1;
    $types{"$native:WORDCHAR"} = 1;
}
for $i (0x30..0x39, 0x660, 0xFF19) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:ALPHANUMERIC"} = 1;
    $types{"$native:DIGIT"} = 1;
    $types{"$native:IDCONT"} = 1;
    $types{"$native:WORDCHAR"} = 1;
    $types{"$native:GRAPH"} = 1;
    $types{"$native:PRINT"} = 1;
    $types{"$native:XDIGIT"} = 1 if $i < 255 || ($i >= 0xFF10 && $i <= 0xFF19);
}

for $i (0..0x7F) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:ASCII"} = 1;
}
for $i (0..0x1f, 0x7F..0x9F) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:CNTRL"} = 1;
}
for $i (0x21..0x7E, 0xA1..0x101, 0x660) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:GRAPH"} = 1;
    $types{"$native:PRINT"} = 1;
}
for $i (0x09, 0x20, 0xA0) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:BLANK"} = 1;
    $types{"$native:SPACE"} = 1;
    $types{"$native:PSXSPC"} = 1;
    $types{"$native:PRINT"} = 1 if $i > 0x09;
}
for $i (0x09..0x0D, 0x85, 0x2029) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:SPACE"} = 1;
    $types{"$native:PSXSPC"} = 1;
}
for $i (0x41..0x5A, 0xC0..0xD6, 0xD8..0xDE, 0x100) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:UPPER"} = 1;
    $types{"$native:XDIGIT"} = 1 if $i < 0x47;
}
for $i (0x61..0x7A, 0xAA, 0xB5, 0xBA, 0xDF..0xF6, 0xF8..0xFF, 0x101) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:LOWER"} = 1;
    $types{"$native:XDIGIT"} = 1 if $i < 0x67;
}
for $i (0x21..0x2F, 0x3A..0x40, 0x5B..0x60, 0x7B..0x7E, 0xB6, 0xA1, 0xA7, 0xAB,
        0xB7, 0xBB, 0xBF, 0x5BE)
{
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:PUNCT"} = 1;
    $types{"$native:GRAPH"} = 1;
    $types{"$native:PRINT"} = 1;
}

$i = ord('_');
$types{"$i:WORDCHAR"} = 1;
$types{"$i:IDFIRST"} = 1;
$types{"$i:IDCONT"} = 1;

# Now find all the unique code points included above.
my %code_points_to_test;
my $key;
for $key (keys %types) {
    $key =~ s/:.*//;
    $code_points_to_test{$key} = 1;
}

# And test each one
for $i (sort { $a <=> $b } keys %code_points_to_test) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    my $hex = sprintf("0x%02X", $native);

    # And for each code point test each of the classes
    my $class;
    for $class (qw(ALPHA ALPHANUMERIC ASCII BLANK CNTRL DIGIT GRAPH IDCONT
                   IDFIRST LOWER PRINT PSXSPC PUNCT SPACE UPPER WORDCHAR
                   XDIGIT))
    {
        if ($i < 256) {  # For the ones that can fit in a byte, test each of
                         #three macros.
            my $suffix;
            for $suffix ("", "_A", "_L1", "_uvchr") {
                my $should_be = ($i > 0x7F && $suffix !~ /_(uvchr|L1)/)
                                ? 0     # Fail on non-ASCII unless unicode
                                : ($types{"$native:$class"} || 0);
                if (ivers($]) < ivers(5.6) && $suffix eq '_uvchr') {
                    skip("No UTF-8 on this perl", 0);
                    next;
                }

                my $eval_string = "Devel::PPPort::is${class}$suffix($hex)";
                my $is = eval $eval_string || 0;
                die "eval 'For $i: $eval_string' gave $@" if $@;
                ok($is, $should_be, "'$eval_string'");
            }
        }

        # For all code points, test the '_utf8' macros
        my $sub_fcn;
        for $sub_fcn ("", "_LC") {
            my $skip = "";
            if (ivers($]) < ivers(5.6)) {
                $skip = $way_too_early_msg;
            }
            elsif (ivers($]) < ivers(5.7) && $native > 255) {
                $skip = "Perls earlier than 5.7 give wrong answers for above Latin1 code points";
            }
            elsif (ivers($]) <= ivers(5.11.3) && $native == 0x2029 && ($class eq 'PRINT' || $class eq 'GRAPH')) {
                $skip = "Perls earlier than 5.11.3 considered high space characters as isPRINT and isGRAPH";
            }
            elsif ($sub_fcn eq '_LC' && $i < 256) {
                $skip = "Testing of code points whose results depend on locale is skipped ";
            }
            my $fcn = "Devel::PPPort::is${class}${sub_fcn}_utf8_safe";
            my $utf8;

            if ($skip) {
                skip $skip, 0;
            }
            else {
                $utf8 = quotemeta Devel::PPPort::uvoffuni_to_utf8($i);
                my $should_be = $types{"$native:$class"} || 0;
                my $eval_string = "$fcn(\"$utf8\", 0)";
                my $is = eval $eval_string || 0;
                die "eval 'For $i, $eval_string' gave $@" if $@;
                ok($is, $should_be, sprintf("For U+%04X '%s'", $native, $eval_string));
            }

            # And for the high code points, test that a too short malformation (the
            # -1) causes it to fail
            if ($i > 255) {
                if ($skip) {
                    skip $skip, 0;
                }
                elsif (ivers($]) >= ivers(5.25.9)) {
                    skip("Prints an annoying error message that khw doesn't know how to easily suppress", 0);
                }
                else {
                    my $eval_string = "$fcn(\"$utf8\", -1)";
                    my $is = eval "no warnings; $eval_string" || 0;
                    die "eval '$eval_string' gave $@" if $@;
                    ok($is, 0, sprintf("For U+%04X '%s'", $native, $eval_string));
                }
            }
        }
    }
}

my %case_changing = ( 'LOWER' => [ [ ord('A'), ord('a') ],
                                   [ 0xC0, 0xE0 ],
                                   [ 0x100, 0x101 ],
                                 ],
                      'FOLD'  => [ [ ord('C'), ord('c') ],
                                   [ 0xC0, 0xE0 ],
                                   [ 0x104, 0x105 ],
                                   [ 0xDF, 'ss' ],
                                 ],
                      'UPPER' => [ [ ord('a'),ord('A'),  ],
                                   [ 0xE0, 0xC0 ],
                                   [ 0x101, 0x100 ],
                                   [ 0xDF, 'SS' ],
                                 ],
                      'TITLE' => [ [ ord('c'),ord('C'),  ],
                                   [ 0xE2, 0xC2 ],
                                   [ 0x103, 0x102 ],
                                   [ 0xDF, 'Ss' ],
                                 ],
                    );

my $name;
for $name (keys %case_changing) {
    my @code_points_to_test = @{$case_changing{$name}};
    my $unchanged;
    for $unchanged (@code_points_to_test) {
        my @pair = @$unchanged;
        my $original = $pair[0];
        my $changed = $pair[1];
        my $utf8_changed = $changed;
        my $is_cp = $utf8_changed =~ /^\d+$/;
        my $should_be_bytes;
        if (ivers($]) >= ivers(5.6)) {
            if ($is_cp) {
                $utf8_changed = Devel::PPPort::uvoffuni_to_utf8($changed);
                $should_be_bytes = Devel::PPPort::UTF8_SAFE_SKIP($utf8_changed, 0);
            }
            else {
                die("Test currently doesn't work for non-ASCII multi-char case changes") if $utf8_changed =~ /[[:^ascii:]]/;
                $should_be_bytes = length $utf8_changed;
            }
        }

        my $fcn = "to${name}_uvchr";
        my $skip = "";

        if (ivers($]) < ivers(5.6)) {
            $skip = $way_too_early_msg;
        }
        elsif (! $is_cp) {
            $skip = "Can't do uvchr on a multi-char string";
        }
        if ($skip) {
            for (1..4) {
                skip $skip, 0;
            }
        }
        else {
            if ($is_cp) {
                $utf8_changed = Devel::PPPort::uvoffuni_to_utf8($changed);
                $should_be_bytes = Devel::PPPort::UTF8_SAFE_SKIP($utf8_changed, 0);
            }
            else {
                die("Test currently doesn't work for non-ASCII multi-char case changes") if $utf8_changed =~ /[[:^ascii:]]/;
                $should_be_bytes = length $utf8_changed;
            }

            my $ret = eval "Devel::PPPort::$fcn($original)";
            my $fail = $@;  # Have to save $@, as it gets destroyed
            ok ($fail, "", "$fcn($original) didn't fail");
            my $first = (ivers($]) != ivers(5.6))
                        ? substr($utf8_changed, 0, 1)
                        : $utf8_changed, 0, 1;
            ok($ret->[0], ord $first,
               "ord of $fcn($original) is $changed");
            ok($ret->[1], $utf8_changed,
               "UTF-8 of of $fcn($original) is correct");
            ok($ret->[2], $should_be_bytes,
               "Length of $fcn($original) is $should_be_bytes");
        }

        my $truncate;
        for $truncate (0..2) {
            my $skip;
            if (ivers($]) < ivers(5.6)) {
                $skip = $way_too_early_msg;
            }
            elsif (! $is_cp && ivers($]) < ivers(5.7.3)) {
                $skip = "Multi-character case change not implemented until 5.7.3";
            }
            elsif ($truncate == 2 && ivers($]) > ivers(5.25.8)) {
                $skip = "Zero length inputs cause assertion failure; test dies in modern perls";
            }
            elsif ($truncate > 0 && length $changed > 1) {
                $skip = "Don't test shortened multi-char case changes";
            }
            elsif ($truncate > 0 && Devel::PPPort::UVCHR_IS_INVARIANT($original)) {
                $skip = "Don't try to test shortened single bytes";
            }
            if ($skip) {
                for (1..4) {
                    skip $skip, 0;
                }
            }
            else {
                my $fcn = "to${name}_utf8_safe";
                my $utf8 = quotemeta Devel::PPPort::uvoffuni_to_utf8($original);
                my $real_truncate = ($truncate < 2)
                                    ? $truncate : $should_be_bytes;
                my $eval_string = "Devel::PPPort::$fcn(\"$utf8\", $real_truncate)";
                my $ret = eval "no warnings; $eval_string" || 0;
                my $fail = $@;  # Have to save $@, as it gets destroyed
                if ($truncate == 0) {
                    ok ($fail, "", "Didn't fail on full length input");
                    my $first = (ivers($]) != ivers(5.6))
                                ? substr($utf8_changed, 0, 1)
                                : $utf8_changed, 0, 1;
                    ok($ret->[0], ord $first,
                       "ord of $fcn($original) is $changed");
                    ok($ret->[1], $utf8_changed,
                       "UTF-8 of of $fcn($original) is correct");
                    ok($ret->[2], $should_be_bytes,
                    "Length of $fcn($original) is $should_be_bytes");
                }
                else {
                    ok ($fail, eval 'qr/Malformed UTF-8 character/',
                        "Gave appropriate error for short char: $original");
                    for (1..3) {
                        skip("Expected failure means remaining tests for"
                           . " this aren't relevant", 0);
                    }
                }
            }
        }
    }
}

ok(&Devel::PPPort::av_top_index([1,2,3]), 2);
ok(&Devel::PPPort::av_tindex([1,2,3,4]), 3);

