#! /usr/bin/perl -w
# File:		modules/Instserver.pm
# Package:	Configuration of instserver
# Summary:	Instserver settings, input and output functions
# Authors:	Anas Nashif <nashif@suse.de>
#
# $Id$
#
# Representation of the configuration of instserver.
# Input and output routines.


package Instserver;

use strict;

use ycp;
use YaST::YCP qw(Boolean);

use Locale::gettext;
use POSIX;     # Needed for setlocale()

setlocale(LC_MESSAGES, "");
textdomain("instserver");

sub _ {
    return gettext($_[0]);
}

our %TYPEINFO;

YaST::YCP::Import ("Progress");
YaST::YCP::Import ("Report");
YaST::YCP::Import ("Summary");


##
 # Data was modified?
 #
my $modified = 0;

##
 #
my $proposal_valid = 0;

##
 # Write only, used during autoinstallation.
 # Don't run services and SuSEconfig, it's all done at one place.
 #
my $write_only = 0;

##
 # Data was modified?
 # @return true if modified
 #
BEGIN { $TYPEINFO {Modified} = ["function", "boolean"]; }
sub Modified {
    y2debug ("modified=$modified");
    return Boolean($modified);
}

# Settings: Define all variables needed for configuration of instserver
# TODO FIXME: Define all the variables necessary to hold
# TODO FIXME: the configuration here (with the appropriate
# TODO FIXME: description)
# TODO FIXME: For example:
#   ##
#    # List of the configured cards.
#    #
#   my @cards = ();
#
#   ##
#    # Some additional parameter needed for the configuration.
#    #
#   my $additional_parameter = 1;

##
 # Read all instserver settings
 # @return true on success
 #
BEGIN { $TYPEINFO{Read} = ["function", "boolean"]; }
sub Read {

    # Instserver read dialog caption
    my $caption = _("Initializing instserver Configuration");

    # TODO FIXME Set the right number of stages
    my $steps = 4;

    my $sl = 0.5;
    sleep($sl);

    # TODO FIXME Names of real stages
    # We do not set help text here, because it was set outside
    Progress::New( $caption, " ", $steps, [
	    # Progress stage 1/3
	    _("Read the database"),
	    # Progress stage 2/3
	    _("Read the previous settings"),
	    # Progress stage 3/3
	    _("Detect the devices")
	], [
	    # Progress step 1/3
	    _("Reading the database..."),
	    # Progress step 2/3
	    _("Reading the previous settings..."),
	    # Progress step 3/3
	    _("Detecting the devices..."),
	    # Progress finished
	    _("Finished")
	],
	""
    );

    # read database
    Progress::NextStage();
    # Error message
    if(0)
    {
	Report::Error(_("Cannot read the database1."));
    }
    sleep($sl);

    # read another database
    Progress::NextStep();
    # Error message
    if(0)
    {
	Report::Error(_("Cannot read the database2."));
    }
    sleep($sl);

    # read current settings
    Progress::NextStage();
    # Error message
    if(0)
    {
	Report::Error(_("Cannot read current settings."));
    }
    sleep($sl);

    # detect devices
    Progress::NextStage();
    # Error message
    if(0)
    {
	Report::Warning(_("Cannot detect devices."));
    }
    sleep($sl);

    # Progress finished
    Progress::NextStage();
    sleep($sl);

    $modified = 0;
    return Boolean(1);
}

##
 # Write all instserver settings
 # @return true on success
 #
BEGIN { $TYPEINFO{Write} = ["function", "boolean"]; }
sub Write {

    # Instserver read dialog caption
    my $caption = _("Saving instserver Configuration");

    # TODO FIXME And set the right number of stages
    my $steps = 2;

    my $sl = 0.5;
    sleep($sl);

    # TODO FIXME Names of real stages
    # We do not set help text here, because it was set outside
    Progress::New($caption, " ", $steps, [
	    # Progress stage 1/2
	    _("Write the settings"),
	    # Progress stage 2/2
	    _("Run SuSEconfig")
	], [
	    # Progress step 1/2
	    _("Writing the settings..."),
	    # Progress step 2/2
	    _("Running SuSEconfig..."),
	    # Progress finished
	    _("Finished")
	],
	""
    );

    # write settings
    Progress::NextStage();
    # Error message
    if(0)
    {
	Report::Error (_("Cannot write settings."));
    }
    sleep($sl);

    # run SuSEconfig
    Progress::NextStage ();
    # Error message
    if(0)
    {
	Report::Error (_("SuSEconfig script failed."));
    }
    sleep($sl);

    # Progress finished
    Progress::NextStage();
    sleep($sl);

    return Boolean(1);
}

##
 # Get all instserver settings from the first parameter
 # (For use by autoinstallation.)
 # @param settings The YCP structure to be imported.
 # @return boolean True on success
 #
BEGIN { $TYPEINFO{Import} = ["function", "boolean", [ "map", "any", "any" ] ]; }
sub Import {
    my %settings = %{$_[0]};
    # TODO FIXME: your code here (fill the above mentioned variables)...
    return Boolean(1);
}

##
 # Dump the instserver settings to a single map
 # (For use by autoinstallation.)
 # @return map Dumped settings (later acceptable by Import ())
 #
BEGIN { $TYPEINFO{Export}  =["function", [ "map", "any", "any" ] ]; }
sub Export {
    # TODO FIXME: your code here (return the above mentioned variables)...
    return {};
}

##
 # Create a textual summary and a list of unconfigured cards
 # @return summary of the current configuration
 #
BEGIN { $TYPEINFO{Summary} = ["function", [ "list", "string" ] ]; }
sub Summary {
    # TODO FIXME: your code here...
    # Configuration summary text for autoyast
    return (
	_("Configuration summary ...")
    );
}

##
 # Create an overview table with all configured cards
 # @return table items
 #
BEGIN { $TYPEINFO{Overview} = ["function", [ "list", "string" ] ]; }
sub Overview {
    # TODO FIXME: your code here...
    return ();
}

##
 # Return packages needed to be installed and removed during
 # Autoinstallation to insure module has all needed software
 # installed.
 # @return map with 2 lists.
 #
BEGIN { $TYPEINFO{AutoPackages} = ["function", ["map", "string", ["list", "string"]]]; }
sub AutoPackages {
    # TODO FIXME: your code here...
    my %ret = (
	"install" => (),
	"remove" => (),
    );
    return \%ret;
}

# EOF
