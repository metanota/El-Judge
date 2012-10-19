
@array1 = split " ", <>;
@array2 = split " ", <>;
pop @array1;
pop @array2;
$hash1{$_} = $_ foreach @array1;
foreach (@array2) { $temp{$_} = $_ if $_ == $hash1{$_}; }
$str .= $_." " foreach keys %temp;
$str ? print $str : print 'empty';
