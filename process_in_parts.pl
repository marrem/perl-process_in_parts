#!/usr/bin/perl
use warnings;
use strict;

use Data::Dumper;


my @list;
for (my $i = 0; $i < 95; $i ++) {
	push @list, $i;
}

print "List first item: $list[0]\n";
print "List last item: $list[-1]\n";

my @set;
my $setNr = 0;
my $set_succesfull = 1;
while (1) {
  if ($set_succesfull) {
    @set = splice(@list, 0, 10)
  }
  last unless (@set);
	eval {
			process_set(\@set, $setNr);
      $set_succesfull = 1;
      $setNr ++;
	};
	if ($@) {
		my $e = $@;
    $set_succesfull = 0;
		print "Set $setNr went wrong\n";
    print "Rollback set $setNr\n";
    rollback_set(\@set, $setNr);
    print "Will retry $setNr in next cycle\n";
	}
}




sub process_set {
	my $entryNr = 0;
	my $set = shift;
	my $setNr = shift;
	foreach my $item (@$set) {
		print "Processing entry $entryNr from set $setNr, which is item $item\n";
		if (int(rand(10)) == 8) {
			die "Oops, Something went wrong!\n";
		}
		$entryNr ++;
	}
}


sub rollback_set {
	my $set = shift;
	my $setNr = shift;
  print "Rolling back set nr $setNr\n";
}
