
$max = -2**31;
while(<>){
    foreach(split) { $max = $_ if ($_ > $max); }
}
print $max;

# This solution cause system violation
# use List::Util qw(max);
# print max(split " ", <>);
