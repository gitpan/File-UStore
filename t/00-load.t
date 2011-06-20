# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 00-load.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More qw/no_plan/;
use lib './lib', './blib/lib';

BEGIN { 
	use_ok('File::UStore');
    use_ok('File::Spec');
};

    my $storageFolder = File::Spec->catdir(File::Spec->tmpdir(),'.teststore');
    diag("Conducting Storage  tests at temp directory $storageFolder");
    my $store = new File::UStore( path => $storageFolder, 
                              prefix => "prefix_",
                              depth  => 1
                            );
    cmp_ok(ref($store),'eq','File::UStore','is a File::UStore');
    open( my $file, "t/00-load.t" ) or die "Unable to open file ";
    my $id = $store->add(*$file);
    like($id,qr/^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$/,'Checking if we really got a UUID as a pointer!!haha I said pointer!!');
    close ($file);
    my $location = $store->getPath("$id");
    my $handle = $store->get("$id");
    SKIP: {
        eval "use Digest::SHA";
        skip 'Digest::SHA is not available',2 if $@ ;
        $sha = Digest::SHA->new('sha256');
        $sha->addfile('t/00-load.t');
        my $orig_file_hash = $sha->hexdigest();
        $sha->addfile($location);
        my $stored_file_hash = $sha->hexdigest();
        $sha->addfile(*$handle);
        my $handle_file_hash = $sha->hexdigest();
        cmp_ok($orig_file_hash,'eq',$stored_file_hash,'Stored file path');
        cmp_ok($orig_file_hash,'eq',$handle_file_hash,'File Handle retrieval');
    }

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

