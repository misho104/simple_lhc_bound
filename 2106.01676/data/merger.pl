use strict;
use warnings;

my $files = [
  [
    'tabaux_16.csv',
    'merged_WinoParaWZ.csv',
    'HEPData-ins1866951-v1-AuxFig_8a_WZ_Excl._Upper_Limit_Obs._Wino-bino(+)_(Delta_m).csv',
    'HEPData-ins1866951-v1-AuxFig_8c_WZ_Excl._Upper_Limit_Obs._Wino-bino(+)_(Delta_m).csv'
  ], [
    'tabaux_17.csv',
    'merged_WinoOppoWZ.csv',
    'HEPData-ins1866951-v1-AuxFig_8e_WZ_Excl._Upper_Limit_Obs._Wino-bino(-)_(Delta_m).csv'
  ], [
    'tabaux_18.csv',
    'merged_HiggsinoWZ.csv',
    'HEPData-ins1866951-v1-AuxFig_8g_WZ_Excl._Upper_Limit_Obs._Higgsino_(Delta_m).csv',
  ], [
    'tabaux_19.csv',
    'merged_WinoParaWH.csv',
    'HEPData-ins1866951-v1-AuxFig_9a_Wh_Excl._Upper_Limit_Obs..csv'
  ],
];


sub normalize{
  my $n = shift;
  $n =~ s/\.0+//;
  if($n !~ /\./){ $n .= ".0"; }
  $n = (0 x (6 - length($n))) . $n;
  die unless $n =~ /^\d\d\d\d\.\d$/;
  return $n;
}

sub labelize{
  return normalize($_[0]) . "," . normalize($_[1]);
}

foreach my $f(@$files){
  open(my $base, "<", $f->[0]);
  open(my $output, ">", $f->[1]);
  my %data;
  foreach(<$base>){
    chomp;
    next unless /,/;
    my ($x, $y, $z, @dummy) = split(/,/, $_);
    my $key = labelize($x, $y);
    $data{$key} = $z;
  }

  for(my $i = 2; $i < @$f; $i++){
    open(my $update, "<", $f->[$i]);
    foreach(<$update>){
      chomp;
      next if (/[a-zA-Z]/ or not /,/);
      my ($x, $y, $z, @dummy) = split(/,/, $_);
      my $key = labelize($x, $y);
      if(exists($data{$key})){
        if($data{$key} != $z){
          print("update:\t" . $data{$key} . "\t-> " . $z . "\t... " . int(100-($z / $data{$key})*100) . "%\n");
          $data{$key} = $z;
        }
      }else{
        print("Orphan: $_\n");
        exit(1);
      }
    }
    close($update);
  }

  foreach my $k(sort(keys(%data))){
    my ($x, $y) = split(/,/, $k);
    print $output ($x+0, ",", $y+0, ",", $data{$k}, "\n");
  }
  close($base);
  close($output);
}
