#!/bin/perl
use strict;
use warnings;
use 5.010;

use Math::BigInt;

sub get_num{
    my $num = shift;
    my $line = shift;
    chomp $num;
    if($num =~ /([^\d-])/){
        #warn "Found non-number in input file on line $line: \"$1\", removing non-numbers from line\n";
        $num =~ s/[^\d-]//g;
    }
    return $num;
}

my $k;
my $e;
my $n;
{
    open(my $fh, "<", "PerlInput.txt") or die "Failed to open file: $!";
    my @file_lines = <$fh>;
    $k = get_num($file_lines[0], 1);
    $e = get_num($file_lines[1], 2);
    $n = get_num($file_lines[2], 3);
    close $fh;
}

my $answer = Math::BigInt->new($k);

# In perl the ^ character is for XOR, while ** is for power
# I assume you were trying to do power, but if not I added the XOR version too

$answer->bmodpow($e,$n);

#$answer->bxor($e);
#$answer->bmod($n);

{
    open(my $fh, ">", "PerlOutput.txt") or die "Failed to open file: $!";
    print $fh $answer;
    close $fh;
}