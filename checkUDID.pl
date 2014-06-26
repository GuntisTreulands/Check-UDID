#!/usr/bin/perl

use utf8;
use File::Path;
use Cwd 'abs_path';
use Getopt::Long;
use File::Basename;
use Pod::Usage;
use Archive::Zip;
use Path::Class qw( file );

# -----------------------------------------------------------------
# Main Program
# -----------------------------------------------------------------

handleArguments();

# -----------------------------------------------------------------
# Sub Routines
# -----------------------------------------------------------------

sub handleArguments() 
{
    glob $inFileName;
	
	glob $inUDID;
    
	glob $timestamp = localtime(time);

	my $UDIDCheckerStarted = 0;
	
	my $UDIDComposer = 0;
	
	my $UDIDComparer = 0;
	
	my $tmpUDID = '';

    my $argvSize = @ARGV;
    
	
	my ($file, $dir, $ext) = fileparse($ARGV[0], qr/\.[^.]*/);
	
	$inFileName = $dir . $file . $ext;

	
    if($argvSize > 1) 
	{
        $inUDID = $ARGV[1]; # WE AQUIRE UDID , if it was provided.
	}
  	
	
	# --- We unrar .ipa file, that was provided
	glob $destinationDirectory = $dir . '/' . $timestamp;
	
	my $zip = Archive::Zip->new($inFileName);
	
	foreach my $member ($zip->members)
	{
	    next if $member->isDirectory;
	    (my $extractName = $member->fileName) =~ s{.*/}{};
	    $member->extractToFileNamed("$destinationDirectory/$extractName");
	}
	# ===
	
	
	
	# --- Open folder, scan for that file with UDIDS.
	chdir($destinationDirectory);
	
	open ( INFILE, "<embedded.mobileprovision" )
		  || die "Can't find file embedded.mobileprovision...exiting \n";
	# ===
	
	print "Attached UDIDS:";
	
	# --- Scan each line
	while ($line = <INFILE>) 
	{
        chop $line;
		
		if($UDIDCheckerStarted == 1) # WE HAVE UDID LINE. aquire only UDID characters. Do comparing with provided UDID (if was provided)
		{
			$tmpUDID = '';
			
			$UDIDComposer = 0;
			
			foreach $char (split //, $line) 
			{
				if($char eq '>' && $UDIDComposer == 0)  # OK, WE START SAVING OUR TEMP UDID STRING
			  	{
					$UDIDComposer = 1;
			  	}
			  	elsif($char eq '<' && $UDIDComposer == 1) # OK, WE END SAVING OUR TEMP UDID STRING
			  	{
					$UDIDComposer = 0;
			  	}
				elsif($UDIDComposer == 1)
				{
					$tmpUDID .= '' . $char;
				}
				
			}
			
			 print $tmpUDID . "\n"; # PRINT OUT UDID AS A BEAUTIFUL LIST
			
			 if($inUDID eq $tmpUDID && length($inUDID) > 5)  # COMPARE WITH PROVIDED UDID (CHECK IF IT WAS PROVIDED - if lenght bigger than five, it is worth checking)
			 {
			 	$UDIDComparer = 1;
			 }
		}
		
		if (index($line, 'ProvisionedDevices') != -1)  		# OK, NOW WE START LOOKING FOR UDIDS
		{
			$UDIDCheckerStarted = 1;
		} 
		
		
		if (index($line, '</array>') != -1 && $UDIDCheckerStarted == 1)  # STOP. WE DO NOT NEED TO SEARCH FURTHER
		{
			$UDIDCheckerStarted = 0;
			
			last;
		}
	}

	close INFILE;
	
	
	# --- AQUIRE ORIGINAL FOLDER, GO TO IT, DELETE THIS NEWLY CREATED FOLDER.
	my ($file2, $origDirectory2, $ext2) = fileparse(abs_path($inFilename), qr/\.[^.]*/);
	
	chdir ($origDirectory2);
	
	rmtree($timestamp) or die "Cannot rmtree '$timestamp' : $! Delete it Yourself!";
	# ===
	
	
	# --- IF WE PROVIDED UDID - PRINT OUT RESULT
	if($UDIDComparer == 1 && length($inUDID) > 5)
	{
		print "\n\n\nUDID: " . $inUDID . " FOUND!\n\n\n";
	}
	elsif($UDIDComparer == 0 && length($inUDID) > 5)
	{
		print "\n\n\nUDID: " . $inUDID . " NOT FOUND!\n\n\n";
	}
	# ===
}
