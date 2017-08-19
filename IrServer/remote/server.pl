#!/usr/bin/env perl
# $Id$ -*- perl -*-
# irconf-to-html.pl
#
# Author: Greg J. Badros - badros@cs.washington.edu
# Copyright (C) 2009 Greg J. Badros
#
# This file is part of IrServer
# 
# IrServer is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# IrServer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with IrServer.  If not, see <http://www.gnu.org/licenses/>.
#
# NOTE: You may want to add the line 
# text/css			css
# to ~/.mime.types
# See LWP::MediaTypes for more information

## TODO:
# Send mime-types properly for CSS, JS, and HTML (doesn't seem to be an issue
# on my ipod touch, but matters when testing on Firefox 3 on a PC


require 5.005;
use warnings;
use Getopt::Std;
use File::Basename;
use strict;
use HTTP::Daemon;
use HTTP::Status;
#use Carp;

#require Exporter;
#@ISA = qw(Exporter);
#@EXPORT = qw();

my $getopts_option_letters = 'h';
use vars qw($opt_h);

my $prg = basename("$0");

sub usage () {
  die "@_
Usage: $prg [-$getopts_option_letters]
-h            Help. Display this usage information
";
}


if (defined($ARGV[0]) && $ARGV[0] eq "--help") {
  usage();
  exit 0;
}

getopts($getopts_option_letters);
if ($opt_h) {
  usage();
  exit 0;
}

# Main routine
my $d = new HTTP::Daemon( LocalPort => 9174 )
  or die "Cannot start HTTP::Daemon on port 9174";
print "Please contact me at: <URL:", $d->url, ">\n";
while (my $c = $d->accept) {
  while (my $r = $c->get_request) {
    if ($r->method eq 'GET' and $r->url->path eq "/") {
      $c->send_file_response("remote.html");
    } elsif ($r->method eq 'GET' and $r->url->path =~ m/^\/?(iui\/[-.\n\w]+)$/) {
      my $f = $1;
      $c->send_file_response($f);
      print STDERR "sending $f\n";
    } elsif ($r->method eq 'GET' and $r->url->path =~ m/^\/(\w+\.html?)$/) {
      my $f = $1;
      $c->send_file_response($f);
      print STDERR "sending $f\n";
    } else {
      $c->send_error(RC_FORBIDDEN)
    }
  }
  $c->close;
  undef($c);
}

END {
  if (defined($d)) {
    $d->close();
  }
}

__END__

=head1 NAME

server.pl -- Simple HTTP server to avoid having to run anything fancier just to serve up some static HTML, JS, and CSS

=head1 SYNOPSIS 

=head1 DESCRIPTION

I<Disclaimer: You choose to use this script at your own risk!>

=head1 BUGS

Certainly.


=head1 SEE ALSO

Linux Infrared Remote Control (LIRC) Homepage - http://lirc.org

=head1 COPYRIGHT
Copyright (C) 2009, Greg J. Badros

=head1 LICENSE

This file is part of IrServer

IrServer is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

IrServer is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with IrServer.  If not, see <http://www.gnu.org/licenses/>.

=head1 AUTHOR

Greg J. Badros - <Fbadros@cs.washington.edu>


=cut
