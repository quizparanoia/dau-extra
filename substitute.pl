# dau.pl - http://dau.pl/
#
# This is a file --substitute can use.
# You can use any perlcode in here.
# $_ contains the text you can work with.
# $_ has to contain the data to be returned to dau.pl at the end.

################################################################################
# Configuration
################################################################################

my $config_file = "$option{dau_files_root_directory}/substitute_config.pl";

if (-e $config_file && -r $config_file) {
	my $return = do $config_file;

	if ($@ || !defined($return)) {
		return $_;
	}
}

################################################################################
# Nicks
################################################################################

my %nicks;

# HTWG
push(@{ $nicks{HTWG} }, ('Hochschule Konstanz (Technik, Wirtschaft und Gestaltung. Univeristy of Applied Sciences.)'));
push(@{ $nicks{HTWG} }, ('HTWG (Hochschule für Technik, Wirtschaft und Gestaltung)'));


# KIT
push(@{ $nicks{KIT} }, ('KIT (Kaustubh Institute of Training)'));
push(@{ $nicks{KIT} }, ('KIT (Kaustubh Institute of Training -- Training / Placement / Outsorcing)'));
push(@{ $nicks{KIT} }, ('KIT (Karlsruhe Institute of Technology)'));
push(@{ $nicks{KIT} }, ('KIT (Knight Industries Two Thousand)'));
push(@{ $nicks{KIT} }, ('KITT'));
push(@{ $nicks{KIT} }, ('KITT (Knight Industries Two Thousand)'));
push(@{ $nicks{KIT} }, ('KIT (Universität des Landes Baden-Württemberg und nationales Forschungszentrum in der Helmholtz-Gemeinschaft)'));
push(@{ $nicks{KIT} }, ('KIT (University of the State of Baden-Wuerttemberg and National Laboratory of the Helmholtz Association)'));

foreach my $nick (keys %nicks) {
	my $arrayref = $nicks{$nick};

	s/\b \Q$nick\E [_]* ([:.,\s]?)/$nick$1/gix;
	if ($config_multiple_substitutions) {
		s/\b(?<![\\])\Q$nick\E\b/@$arrayref[rand(@$arrayref)]/egi;
	} else {
		my $substitution = @$arrayref[rand(@$arrayref)];
		s/\b(?<![\\])\Q$nick\E\b/$substitution/gi;
	}
	s/\\$nick/$nick/gi;
}

################################################################################
# Other stuff, not nicks
################################################################################

my %other;

if ($config_tourette) {
	my @tourette = (
	                "GNNNNNNNNNNNN ARSCHFICKERIN",
	                "UUUUUUUUUUUUUUUHHH ARSCHLOCH",
	);
	foreach my $item (@tourette) {
		if (int(rand(100) < 25)) {
			push(@{ $other{das} }, "das " . $item);
		}
		if (int(rand(100) < 25)) {
			push(@{ $other{der} }, "der " . $item);
		}
	}
}

if ($config_ichbin) {
	push(@{ $other{ich} }, ('ich, der ich seltendämlich bin,'));
	push(@{ $other{ich} }, ('ich, der ich einen kleinen Wurm habe,'));
	push(@{ $other{ich} }, ('ich, der ich widerlich stinke,'));
	push(@{ $other{ich} }, ('ich')) for (1..5);
}

if ($config_calimero) {
	# dass -> das
	push(@{ $other{dass} }, ('das'));

	# Kommilitone -> Kommolitone
	push(@{ $other{kommilitone} }, ('kommolitone'));
	push(@{ $other{kommilitonen} }, ('kommolitonen'));

	# desillusioniert unpassend einbauen
	push(@{ $other{'blöd'} }, ('desillusioniert'));
	push(@{ $other{bloed} }, ('desillusioniert'));
	push(@{ $other{daemlich} }, ('desillusioniert'));
	push(@{ $other{seltendaemlich} }, ('aeusserst desillusioniert'));
	push(@{ $other{'dämlich'} }, ('desillusioniert'));
	push(@{ $other{'seltendämlich'} }, ('äußerst desillusioniert'));
	push(@{ $other{dumm} }, ('desillusioniert'));
	push(@{ $other{saudumm} }, ('extrem desillusioniert'));
	push(@{ $other{gay} }, ('desillusioniert'));
	push(@{ $other{sachlich} }, ('desillusioniert'));
	push(@{ $other{unsachlich} }, ('nicht desillusioniert'));
	push(@{ $other{schwul} }, ('desillusioniert'));
	push(@{ $other{idiotisch} }, ('desillusioniert'));

	# herausprangern reinprangern
	push(@{ $other{hervorstechen} }, ('herausprangern'));
	push(@{ $other{aussehen} },( 'herausprangern'));
}

push(@{ $other{fullack} }, ('Beate Vollack'));
push(@{ $other{fullack} }, ('Jens Ackermann'));
push(@{ $other{fullack} }, ('Josef Ackermann'));
push(@{ $other{fullack} }, ('Michael Ballack'));

push(@{ $other{lol} }, ('Bob Lulz'));
push(@{ $other{lol} }, ('Benjamin Lolz'));

push(@{ $other{lolack} }, ('Poetra Lolack'));

foreach my $item (keys %other) {
	my $arrayref = $other{$item};

	s/\b(?<![\\])\Q$item\E\b/@$arrayref[rand(@$arrayref)]/egix;
	s/\\$item/$item/gi;
}
