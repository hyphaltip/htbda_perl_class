#Leftover - reading files from directories

* To open and read names of files in a directory you need two
  functions
* `opendir` to open a directory, works like open does for files (only
  you can only read a directory) and `readdir` to get a list of files
  in a directory

        !perl
		opendir(DIR,"mydir") || die "cannot open dir: $!"
		foreach my $file ( readdir(DIR) ) {
			print "file is $file\n";
			if( $file eq 'special.dat' ) {
				open(IN, "mydir/$file") || die $!;
				while(<IN>) {
				}
			}
		}
---
#Leftover - making / deleting a directory

* `mkdir` will create a directory through perl
* `rmdir` will remove an empty directory in perl


---
#References

Reference are ways to refer to a complicated data structures as a
single, scalar value. This lets one pass around multiple arrays and
they stay separate. We also primarily use reference to store multiple
things in a slot in an array.  

* Reference to an array is done with `\` or `[]`
* Reference to a hash is done with `\` or `{}`

For example this lets one pass around multiple
arrays and they aren't flattened into one. Consider this code.

    !perl
    my @array1 = qw(A B C D);
    my @array2 = qw(W X Y Z);
    my @array3 = (@array1, @array2);

    print join(",", @array3), "\n";

---
#Storing multiple items in an Array

    [ 0 | 1 | 2 ]
      |   |
      |   -------------------------
     { apple => 'red' ,           |
       turtle => 'green' }      { bannana => 'yellow',
                                  pig     => 'pink' }


Often we use this approach to store multiple things for a single key
in hash too. What if a gene has mutiple protein domains, function, or
other information you wanted to store for it?

---
#Array of Arrays

	!perl
	my @matrix = ( [qw( 1 0 0 0) ],
	               [qw( 0 1 0 0) ],
				   [qw( 0 0 1 0) ],
				   [qw( 0 0 0 1) ] );
				   
	for my $row ( @matrix ) {
		print join(",", @$row), "\n";
	}

	push @matrix, [qw(1 1 1 1)];

---
#Array of Hashes

* can have arrays made up of Hashes

		!perl
		my @favorites = ( {
		'name'  => 'worm_1',
		'fruit' => 'apple',
		'size'  => 12 });
		push @favorites, { 'name' => 'worm_2',
		'fruit' => 'pear',
		'size'  => 10};

		for my $record ( @favorites) {
			print "name is ", $record->{'name'}, " and size is ",
			$record->{'size'}, "\n";
		}


---
#Hash of Arrays

* The pockets of the roulette wheel are numbered from 1 to 36.
* In number ranges from 1 to 10 and 19 to 28, odd numbers are red and even are black.
 * In ranges from 11 to 18 and 29 to 36, odd numbers are black and even are red.


		!perl
		my %roulette = ( 'Black' => [],
	                     'Red'   => [] );
		foreach my $num ( 1..10, 19..28 ) { # .. operator just lists all numbers in a range
			if( $num % 2 == 0 ) { # even
				push @{$roulette{'Black'}}, $num;
			} else {
				push @{$roulette{'Red'}}, $num;
			}
		}
		foreach my $num ( 11..18, 29..36 ) {
			if( $num % 2 == 0 ) { # even
				push @{$roulette{'Red'}}, $num;
			} else { push @{$roulette{'Black'}}, $num; }
		}
		for my $color ( keys %roulette ) {
			print "$color: ",join(",", @{$roulette{$color}}),"\n";
		}

---
#Hashes of Hashes

* can make hashes that contain hashes. This makes for convient data
structures once you get the hang of it.

		!perl
		my %tickets;
		$tickets{'section 1'}->{'row 2'}->{'seat A'} = '$10'; 

		my $genes; # make this a hash reference
		$genes->{'p53'}->{'length'} = 300;
		$genes->{'p53'}->{'exons'} = 6;
	

---
#Combing hashes of hashes

> [http://courses.stajich.org/public/gen220/data/Nc3H.expr.tab](http://courses.stajich.org/public/gen220/data/Nc3H.expr.tab)
> [http://courses.stajich.org/public/gen220/data/Ncrassa_OR74A_InterproDomains.tab](Ncrassa_OR74A_InterproDomains.tab)

    !perl
    my $url = 'http://courses.stajich.org/public/gen220/data/Ncrassa_OR74A_InterproDomains.tab';
    open(my $fh => "GET $url |") || die $!;
    my %genes;
    while(<$fh>) {
    	my ($gene,$domain, $domain_name, $start,$end,$score) = split;
	# store an array as the value for each key by making it a reference to an array
	# using the @{$genes{$gene}} which is forcing what is the value 
	# to be an array reference. Then we use push to add something to
	# this array
	# Because perl will automatically initialize the value, based on the context
	# we DON'T need to do this, but it is what is happening under the hood
	# if this is the first time accessing this key
	# $genes{$gene} = [];
	 push @{$genes{$gene}}, $domain_name;
    }
    # now unpack to print this out
    for my $gene ( keys %genes ) {
    	my @domains = @{$genes{$gene}};
		print join("\t", $gene, join(",", @domains)), "\n";
    } 


---
#Subroutines

* subroutines are blocks of code that can be reused
* start with `sub` and have a name and then are enclosed in code block
  of `{}` 


		!perl
		sub a_routine {
			my @args = @_; # the arguments passed in are avaialable as @_;
			print "the arguments are ", join(",", @args), "\n";
		}
		# here is code to call this subroutine
		&a_routine('a','b','c');

* Not required to define the subroutine before you use it, so you can
  writ all your subroutines at the bottom of your file
* Or store in a separate file and bring in with `require`

---
#Subroutine arguments

* Always a list, if you want to have some things stay grouped, you
  must use references.


		!perl

		&evaluate( qw(a b c), qw(Z Y X));
		sub evaluate {
			my (@list) = @_;
			
		}
