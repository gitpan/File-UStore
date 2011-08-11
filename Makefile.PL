
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Perl extension to store files on a filesystem using a non-hash UUID(Universally Unique Identifier) based randomised storage with depth of storage options.',
  'AUTHOR' => 'Shantanu Bhadoria <shantanu at cpan dott org>',
  'BUILD_REQUIRES' => {
    'Test::More' => '0.47'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'File-UStore',
  'EXE_FILES' => [],
  'LICENSE' => 'gpl',
  'NAME' => 'File::UStore',
  'PREREQ_PM' => {
    'File::Copy' => '0',
    'File::Path' => '0',
    'File::Spec' => '0',
    'UUID' => '0'
  },
  'VERSION' => '0.11',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



