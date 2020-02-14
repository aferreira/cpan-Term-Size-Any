
package Term::Size::Any;

use strict;
use vars qw( $VERSION );

$VERSION = '0.002';

my $PACKAGE;

sub _require_any {
    return $PACKAGE
        if $PACKAGE;

    if ( $^O eq 'MSWin32' ) {
        require Term::Size::Win32;
        $PACKAGE = 'Term::Size::Win32';

    } else {
        #require Best;
        #my @modules = qw( Term::Size::Perl Term::Size Term::Size::ReadKey );
        #Best->import( @modules );
        #$package = Best->which( @modules );
        require Term::Size::Perl;
        $PACKAGE = 'Term::Size::Perl';

    }

    $PACKAGE->import( qw( chars pixels ) ); # allows Term::Size::Any::chars
    return $PACKAGE;
}

sub import {
    my $self = shift;
    my $package = _require_any;
    unshift @_, $package;
    my $import_sub = $package->can('import');
    goto &$import_sub;
}

sub chars {
    _require_any;
    goto &chars;
}

sub pixels {
    _require_any;
    goto &pixels;
}

1;
