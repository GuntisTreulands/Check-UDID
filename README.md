Check UDIDs in .ipa file (Perl script)
===

A possibility to print out in console all UDID's that are assigned to corresponding .ipa file. Or - provide a UDID and it will also notify if provided UDID is found between printed out UDID's.



checkUDID.pl usage instructions
===

For Mac:
Open terminal, cd /to/folder/where/is/located/checkUDID.pl/and/Your/.ipa/file

Then type ./checkUDID.pl app_v0.1.ipa

and it will print out something like this:
    
	Attached UDIDS:
    50ed155ed73309e512512109sasdioisad0s45us
    ee60d9f2099ea549ff0lk24kh242kj3i6u36iu34
    4c87c6ebd8fbdj23jh322jh525nnk52k42kj232k
    ca65c939291ed5e24j5kj636k63kj2b4j24jh24l
    494601deec306c2a2kl2k4llj536k3j6k34kj2l3
    3498c7688a2e4cf02k4l2k21l5k25l2k5l215lk1


If You type ./checkUDID.pl app_v0.1.ipa 494601deec306c2a2kl2k4llj536k3j6k34kj2l3

It will print out:

    Attached UDIDS:
    50ed155ed73309e512512109sasdioisad0s45us
    ee60d9f2099ea549ff0lk24kh242kj3i6u36iu34
    4c87c6ebd8fbdj23jh322jh525nnk52k42kj232k
    ca65c939291ed5e24j5kj636k63kj2b4j24jh24l
    494601deec306c2a2kl2k4llj536k3j6k34kj2l3
    3498c7688a2e4cf02k4l2k21l5k25l2k5l215lk1

    UDID: 494601deec306c2a2kl2k4llj536k3j6k34kj2l3 FOUND!


BSD license
===

	Copyright (c) 2014 Guntis Treulands.
	All rights reserved.

	Redistribution and use in source and binary forms are permitted
	provided that the above copyright notice and this paragraph are
	duplicated in all such forms and that any documentation,
	advertising materials, and other materials related to such
	distribution and use acknowledge that the software was developed
	by Guntis Treulands.  The name of the
	University may not be used to endorse or promote products derived
	from this software without specific prior written permission.
	THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
	IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
	