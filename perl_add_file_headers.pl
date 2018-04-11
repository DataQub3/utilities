#!/usr/bin/env perl

# add headers at the top of files
# how to use:
#   perl add-headers.pl <header file> files

# to add headers to cpp files recursively, use:
#   perl add-headers.pl $(find . -name "*.cpp")

# beware: the script does not check if the file already contains headers !
$cnt = 0;
$header = "";

while (<>) {
    $line = $_;

    if ($ARGV ne $oldargv) {  # are we at the next file?
        if($cnt > 0){
            # rename($ARGV, $ARGV . '.orig'); # if we want a .orig backup
            open(ARGVOUT, ">$ARGV");  # plus error check
            select(ARGVOUT);
            print "$header \n";
        }
        $oldargv = $ARGV;
        $cnt++;
    }

    $header .= $line if $cnt == 1;
    print $line;
}

select (STDOUT);   # restore default output
