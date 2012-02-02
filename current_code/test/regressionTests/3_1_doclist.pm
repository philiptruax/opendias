package regressionTests::3_1_doclist;

use lib qw( regressionTests/lib );
use DBI;
use standardTests;
use Data::Dumper;
use strict;

sub testProfile {
  return {
    valgrind => 1,
    client => 0,
  }; 
} 

sub test {

  $Data::Dumper::Indent = 1;
  $Data::Dumper::Sortkeys = 1;

  my %data = (
    action => 'docFilter',
    subaction => 'fullList',
    isActionRequired => 'false',
    page => '1',
    range => '12',
    sortfield => '3',
    sortorder => '1',
  );
#  my %data = (
#    action => 'doScan',
#    deviceid => 'test:0',
#    format => 'Grey Scale',
#    pages => 1,
#    resolution => '300',
#    ocr => '-',
#    pagelength => '100',
#  );

  # Entry DB
  o_log( "No Rows = " . Dumper( directRequest( \%data ) ) );

  inTestSQL('1'); # Add a simgle document
  o_log( "One Row = " . Dumper( directRequest( \%data ) ) );

  return 0;
}

return 1;

