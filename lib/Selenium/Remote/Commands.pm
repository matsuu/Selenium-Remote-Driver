package Selenium::Remote::Commands;

use strict;
use warnings;

use String::TT qw/tt/;

sub new {
    my $class = shift;
    
    # http://code.google.com/p/selenium/wiki/JsonWireProtocol
    my $self = {
        'newSession' => {
                          'method' => 'POST',
                          'url'    => 'session'
        },
        'getCapabilities' => {
                          'method' => 'GET',
                          'url'    => 'session/[% session_id %]'
        },
        'quit' => {
                    'method' => 'DELETE',
                    'url'    => "session/[% session_id %]"
        },
        'getCurrentWindowHandle' => {
                 'method' => 'GET',
                 'url' => "session/[% session_id %]/window_handle"
        },
        'getWindowHandles' => {
                'method' => 'GET',
                'url' => "session/[% session_id %]/window_handles"
        },
        'getCurrentUrl' => {
                           'method' => 'GET',
                           'url' => "session/[% session_id %]/url"
        },
        'get' => {
                   'method' => 'POST',
                   'url'    => "session/[% session_id %]/url"
        },
        'goForward' => {
                       'method' => 'POST',
                       'url' => "session/[% session_id %]/forward"
        },
        'goBack' => {
                      'method' => 'POST',
                      'url'    => "session/[% session_id %]/back"
        },
        'refresh' => {
                       'method' => 'POST',
                       'url' => "session/[% session_id %]/refresh"
        },
        'executeScript' => {
                       'method' => 'POST',
                       'url' => "session/[% session_id %]/execute"
        },
        'screenshot' => {
                    'method' => 'GET',
                    'url' => "session/[% session_id %]/screenshot"
        },
        'switchToFrame' => {
                'method' => 'POST',
                'url' => "session/[% session_id %]/frame"
        },
        'switchToWindow' => {
             'method' => 'POST',
             'url' => "session/[% session_id %]/window"
        },
        'getSpeed' => {
                        'method' => 'GET',
                        'url' => "session/[% session_id %]/speed"
        },
        'setSpeed' => {
                        'method' => 'POST',
                        'url' => "session/[% session_id %]/speed"
        },
        'getAllCookies' => {
                        'method' => 'GET',
                        'url' => "session/[% session_id %]/cookie"
        },
        'addCookie' => {
                        'method' => 'POST',
                        'url' => "session/[% session_id %]/cookie"
        },
        'deleteAllCookies' => {
                        'method' => 'DELETE',
                        'url' => "session/[% session_id %]/cookie"
        },
        'deleteCookieNamed' => {
             'method' => 'DELETE',
             'url' => "session/[% session_id %]/cookie/[% name %]"
        },
        'getPageSource' => {
                        'method' => 'GET',
                        'url' => "session/[% session_id %]/source"
        },
        'getTitle' => {
                        'method' => 'GET',
                        'url' => "session/[% session_id %]/title"
        },
        'findElement' => {
                       'method' => 'POST',
                       'url' => "session/[% session_id %]/element"
        },
        'findElements' => {
                      'method' => 'POST',
                      'url' => "session/[% session_id %]/elements"
        },
        'getActiveElement' => {
                'method' => 'POST',
                'url' => "session/[% session_id %]/element/active"
        },
        'describeElement' => {
                'method' => 'POST',
                'url' => "session/[% session_id %]/element/[% id %]"
        },
        'findChildElement' => {
            'method' => 'POST',
            'url' => "session/[% session_id %]/element/[% id %]/element"
        },
        'findChildElements' => {
            'method' => 'POST',
            'url' => "session/[% session_id %]/element/[% id %]/elements"
        },
        'clickElement' => {
               'method' => 'POST',
               'url' => "session/[% session_id %]/element/[% id %]/click"
        },
        'submitElement' => {
              'method' => 'POST',
              'url' => "session/[% session_id %]/element/[% id %]/submit"
        },
        'getElementValue' => {
               'method' => 'GET',
               'url' => "session/[% session_id %]/element/[% id %]/value"
        },
        'sendKeysToElement' => {
               'method' => 'POST',
               'url' => "session/[% session_id %]/element/[% id %]/value"
        },
        'isElementSelected' => {
            'method' => 'GET',
            'url' => "session/[% session_id %]/element/[% id %]/selected"
        },
        'setElementSelected' => {
            'method' => 'POST',
            'url' => "session/[% session_id %]/element/[% id %]/selected"
        },
        'toggleElement' => {
              'method' => 'POST',
              'url' => "session/[% session_id %]/element/[% id %]/toggle"
        },
        'isElementEnabled' => {
             'method' => 'GET',
             'url' => "session/[% session_id %]/element/[% id %]/enabled"
        },
        'getElementLocation' => {
            'method' => 'GET',
            'url' => "session/[% session_id %]/element/[% id %]/location"
        },
        'getElementLocationInView' => {
            'method' => 'GET',
            'url' => "session/[% session_id %]/element/[% id %]/location_in_view"
        },
        'getElementTagName' => {
                'method' => 'GET',
                'url' => "session/[% session_id %]/element/[% id %]/name"
        },
        'clearElement' => {
               'method' => 'POST',
               'url' => "session/[% session_id %]/element/[% id %]/clear"
        },
        'getElementAttribute' => {
            'method' => 'GET',
            'url' =>
"session/[% session_id %]/element/[% id %]/attribute/[% name %]"
        },
        'elementEquals' => {
            'method' => 'GET',
            'url' => "session/[% session_id %]/element/[% id %]/equals/[% other %]"
        },
        'isElementDisplayed' => {
            'method' => 'GET',
            'url' => "session/[% session_id %]/element/[% id %]/displayed"
        },
        'close' => {
                     'method' => 'DELETE',
                     'url'    => "session/[% session_id %]/window"
        },
        'dragElement' => {
                'method' => 'POST',
                'url' => "session/[% session_id %]/element/[% id %]/drag"
        },
        'getElementSize' => {
                'method' => 'GET',
                'url' => "session/[% session_id %]/element/[% id %]/size"
        },
        'getElementText' => {
                'method' => 'GET',
                'url' =>
                  "session/[% session_id %]/element/[% id %]/text"
        },
        'getElementValueOfCssProperty' => {
            'method' => 'GET',
            'url' =>
"session/[% session_id %]/element/[% id %]/css/[% property_name %]"
        },
        'getVisible' => {
                       'method' => 'GET',
                       'url' => "session/[% session_id %]/visible"
        },
        'hoverOverElement' => {
               'method' => 'POST',
               'url' =>
                 "session/[% session_id %]/element/[% id %]/hover"
        },
        'setVisible' => {
                       'method' => 'POST',
                       'url' => "session/[% session_id %]/visible"
        },
    };

    bless $self, $class or die "Can't bless $class: $!";
    return $self;
}

# This method will replace the template & return
sub getParams {
    my ($self, $command, $args) = @_;
    if (!(defined $args->{'session_id'})) {
        return;
    }
    my $data = {};

    # TT does lexical template replacement, so we need exact name of the vars.
    my $session_id = $args->{'session_id'};
    my $id      = $args->{'id'};
    my $name    = $args->{'name'};
    my $property_name = $args->{'property_name'};

    $data->{'method'} = $self->{$command}->{'method'};
    $data->{'url'}    = tt $self->{$command}->{'url'};

    return $data;
}

1;

__END__

=head1 SEE ALSO

For more information about Selenium , visit the website at
L<http://code.google.com/p/selenium/>.

=head1 BUGS

The Selenium issue tracking system is available online at
L<http://code.google.com/p/selenium/issues/list>.

=head1 AUTHOR

Perl Bindings for Remote Driver by Aditya Ivaturi <ivaturi@gmail.com>

=head1 LICENSE

Copyright (c) 2010 Juniper Networks, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.