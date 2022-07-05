#!/usr/bin/perl -w
# This script updates the image value of one of the service field names provided. 
# The syntax is:
#    update_image_tag.pl <service_name> <new_image_tag> <docker_compose_YAML_file> 
#
# $service_name - ex. iris, ipa, etc. (found in docker-compose.yml or equivalent)
# $new_image_tag -  ex. docker.iscinternal.com/intersystems/sam:1.0.0.123.0
# $config_filename - ex. docker-compose.yml
#
# This will overwrite the existing tag name for the service. It will also replace
#  the existing docker-compose YAML file with the new version that includes
#  the new image tag.
#
use strict;

use File::Copy;
use YAML::Tiny;

if (scalar @ARGV < 2) {
    &badArgs;
}
else {
    &update_image_tag( @ARGV );
}

# Take the input filename and inserts '.tmp' before '.yml'
sub create_temp_filename {
    my $filename = shift;
    return $filename =~ s/.yml/.tmp.yml/r;
}

# Overwrite the original file with the temporary file 
#  (which should contain fixes to the original file)
sub copy_temp_over_original {
    my ($temp_filename, $orig_filename) = @_;

    # Make the destination file writeable
    chmod 0644, $orig_filename
        or die "ERROR: can't change permissions on config file: $!";

    # Copy the temp file back to original (two-step process is easier for debugging)
    copy($temp_filename, $orig_filename) 
        or die "ERROR: Copy back to '$orig_filename' failed: $!";

    unlink $temp_filename
        or die "ERROR: can't remove temporary file: $!";
}

# This routine replaces all strings that have the keywords 'true' or 'false' with the keyword 
#  itself, i.e. true or false.  This is necessary for the docker-compose utility to accept
#  the YAML file as valid.
sub fix_boolean_types {
    my ($file_name) = @_;

    # the 'r' option preserves the original string
    my $temp_conf_filename = &create_temp_filename ( $file_name );

    open my $fh, "<$file_name";
    open my $fhtmp, ">$temp_conf_filename";

    while (<$fh>)
    {
        s/'true'/true/g;
        s/'false'/false/g;
        print $fhtmp $_;
    }

    close $fh;
    close $fhtmp;

    &copy_temp_over_original($temp_conf_filename, $file_name);
}

sub update_image_tag {
    my $service_name = shift; # ex. iris, ipa, etc. (found in docker-compose.yml or equivalent)
    my $new_image_tag= shift;  # ex. docker.iscinternal.com/intersystems/sam:1.0.0.123.0
    my $config_filename = shift; # ex. docker-compose.yml
    if ( (not defined $config_filename) || ( $config_filename eq "" ) ) {
        $config_filename = "docker-compose.yml";
    }
    # Open the config
    my $yaml = YAML::Tiny->read( $config_filename )
        or die "ERROR: Can't load '$config_filename': $!";
     
    # Get a reference to the first document
    my $config = $yaml->[0];

    my $service_hash_ref =  $config->{'services'}->{$service_name};

    # Throw error if $service_name not in docker-compose.yml file
    die "ERROR: Can't find service '$service_name': $!" if(not defined $service_hash_ref);

    $service_hash_ref->{'image'} = $new_image_tag;

    my $temp_conf_filename = &create_temp_filename ( $config_filename );

    # Save the document back to the temporary file
    $yaml->write( $temp_conf_filename )
        or die "ERROR: Can't save '$temp_conf_filename': $!";

    # This routine is necessary to fix a bug with YAML::Tiny not recognizing boolean types
    &fix_boolean_types ($temp_conf_filename);

    &copy_temp_over_original($temp_conf_filename, $config_filename);
}

sub badArgs {
    print "syntax = $0 <service_name> <container_image_tag> (<config_filename>)\n";
    exit 1;
}
