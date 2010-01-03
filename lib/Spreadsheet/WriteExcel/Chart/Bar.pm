package Spreadsheet::WriteExcel::Chart::Bar;

###############################################################################
#
# Bar - A writer class for Excel Bar charts.
#
# Used in conjunction with Spreadsheet::WriteExcel::Chart.
#
# See formatting note in Spreadsheet::WriteExcel::Chart.
#
# Copyright 2000-2010, John McNamara, jmcnamara@cpan.org
#
# Documentation after __END__
#

require Exporter;

use strict;
use Spreadsheet::WriteExcel::Chart;


use vars qw($VERSION @ISA);
@ISA = qw(Spreadsheet::WriteExcel::Chart Exporter);

$VERSION = '2.32';

###############################################################################
#
# new()
#
#
sub new {

    my $class = shift;
    my $self  = Spreadsheet::WriteExcel::Chart->new( @_ );

    bless $self, $class;

    # The axis positions are reversed for a bar chart so we change the config.
    my $c = $self->{_config};
    $c->{_x_axis_text}     = [ 0x2D,   0x6D9,  0x5F,   0x1CC, 0x281,  0x0, 90 ];
    $c->{_x_axis_text_pos} = [ 2,      2,      0,      0,     0x17,   0x2A ];
    $c->{_y_axis_text}     = [ 0x078A, 0x0DFC, 0x011D, 0x9C,  0x0081, 0x0000 ];
    $c->{_y_axis_text_pos} = [ 2,      2,      0,      0,     0x45,   0x17 ];

    return $self;
}


###############################################################################
#
# _store_chart_type()
#
# Implementation of the abstract method from the specific chart class.
#
# Write the BAR chart BIFF record. Defines a bar or column chart type.
#
sub _store_chart_type {

    my $self = shift;

    my $record    = 0x1017;    # Record identifier.
    my $length    = 0x0006;    # Number of bytes to follow.
    my $pcOverlap = 0x0000;    # Space between bars.
    my $pcGap     = 0x0096;    # Space between cats.
    my $grbit     = 0x0001;    # Option flags.

    my $header = pack 'vv', $record, $length;
    my $data = '';
    $data .= pack 'v', $pcOverlap;
    $data .= pack 'v', $pcGap;
    $data .= pack 'v', $grbit;

    $self->_append( $header, $data );
}

###############################################################################
#
# _set_embedded_config_data()
#
# Setup the default configuration data for an embedded chart.
#
sub _set_embedded_config_data {

    my $self = shift;

    $self->SUPER::_set_embedded_config_data();

    # The axis positions are reversed for a bar chart so we change the config.
    my $c = $self->{_config};
    $c->{_x_axis_text}     = [ 0x57,   0x5BC,  0xB5,   0x214, 0x281, 0x0, 90 ];
    $c->{_x_axis_text_pos} = [ 2,      2,      0,      0,     0x17,  0x2A ];
    $c->{_y_axis_text}     = [ 0x074A, 0x0C8F, 0x021F, 0x123, 0x81,  0x0000 ];
    $c->{_y_axis_text_pos} = [ 2,      2,      0,      0,     0x45,  0x17 ];

}

1;


__END__


=head1 NAME

Bar - A writer class for Excel Bar charts.

=head1 SYNOPSIS

To create a simple Excel file with a Bar chart using Spreadsheet::WriteExcel:

    #!/usr/bin/perl -w

    use strict;
    use Spreadsheet::WriteExcel;

    my $workbook  = Spreadsheet::WriteExcel->new( 'chart.xls' );
    my $worksheet = $workbook->add_worksheet();

    my $chart     = $workbook->add_chart( name => 'Chart1', type => 'bar' );

    # Configure the chart.
    $chart->add_series(
        categories => '=Sheet1!$A$2:$A$7',
        values     => '=Sheet1!$B$2:$B$7',
    );

    # Add the data to the worksheet the chart refers to.
    my $data = [
        [ 'Category', 2, 3, 4, 5, 6, 7 ],
        [ 'Value',    1, 4, 5, 2, 1, 5 ],
    ];

    $worksheet->write( 'A1', $data );

    __END__

=head1 DESCRIPTION

This module implements Bar charts for L<Spreadsheet::WriteExcel>. The chart object is created via the Workbook C<add_chart()> method:

    my $chart = $workbook->add_chart( name => 'Chart1', type => 'bar' );

Once the object is created it can be configured via the following methods that are common to all chart classes:

    $chart->add_series();
    $chart->set_x_axis();
    $chart->set_y_axis();
    $chart->set_title();

These methods are explained in detail in L<Spreadsheet::WriteExcel::Chart>. Class specific methods or settings, if any, are explained below.

=head1 Bar Chart Methods

There aren't currently any bar chart specific methods. See the TODO section of L<Spreadsheet::WriteExcel::Chart>.

=head1 AUTHOR

John McNamara jmcnamara@cpan.org

=head1 COPYRIGHT

Copyright MM-MMX, John McNamara.

All Rights Reserved. This module is free software. It may be used, redistributed and/or modified under the same terms as Perl itself.

