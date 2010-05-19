package WebService::Bitly;

use strict;
use warnings;
our $VERSION = '0.01';

# document:
#  http://code.google.com/p/bitly-api/wiki/ApiDocumentation

use JSON;
use URI;
use LWP::Simple;

our $SUPPORTED = 'v3';

my $json = JSON->new->utf8->ascii(1);
my $base = 'api.bit.ly';

sub new {
    my $package = shift;
    die "require params" unless @_;

    my $self = bless +{ (@_ > 1) ? @_ : @$_[0] }, $package;

    die "require params : login"  if !$self->{login};
    die "require params : apiKey" if !$self->{apiKey};

    return $self;
}

sub shorten {
    my $self = shift;
    my $url  = shift or return;
    my $detail = shift;

    my $uri = URI->new("http://${base}/${SUPPORTED}/shorten");

    $uri->query_form({
        login   => $self->{login},
        apiKey  => $self->{apiKey},
        format  => ($detail) ? 'json' : 'txt',
        longUrl => $url
    });

    warn "[WebService::Bitly] ${uri}\n" if $self->{debug};

    my $result = get("${uri}") or die "${base} is something wrong!";
    return $result unless $detail;

    #TODO: status code
    my $j = $json->decode($result);
    return $j->{data};
}

sub expand {
    my $self = shift;
    my $data = (@_ > 1)? +{ @_ } : $_[0];

    my $uri = URI->new("http://${base}/${SUPPORTED}/expand");

    my $qform = {
        login  => $self->{login},
        apiKey => $self->{apiKey},
        format => 'json',
    };

    $qform->{shortUrl} = $data->{shortUrl} if $data->{shortUrl};
    $qform->{hash}     = $data->{hash} if $data->{hash};

    $uri->query_form($qform);

    warn "[WebService::Bitly] ${uri}\n" if $self->{debug};

    my $result = get("${uri}") or die "${base} is something wrong!";
    #TODO: status code
    my $j = $json->decode($result);
    return $j->{data}{expand};
}

sub validate {
    my $self = shift;
    my ($x_login, $x_apiKey) = @_;
    return if !$x_login || !$x_apiKey;

    my $uri = URI->new("http://${base}/${SUPPORTED}/validate");

    $uri->query_form({
        login    => $self->{login},
        apiKey   => $self->{apiKey},
        x_login  => $x_login,
        x_apiKey => $x_apiKey,
        format   => 'txt',
    });

    warn "[WebService::Bitly] ${uri}\n" if $self->{debug};

    my $result = get("${uri}") or die "${base} is something wrong!";
    return !!$result;
}

sub clicks {
    my $self = shift;
    my $data = (@_ > 1)? +{ @_ } : $_[0];

    my $uri = URI->new("http://${base}/${SUPPORTED}/clicks");

    my $qform = {
        login  => $self->{login},
        apiKey => $self->{apiKey},
        format => 'json',
    };

    $qform->{shortUrl} = $data->{shortUrl} if $data->{shortUrl};
    $qform->{hash}     = $data->{hash} if $data->{hash};

    $uri->query_form($qform);

    warn "[WebService::Bitly] ${uri}\n" if $self->{debug};

    my $result = get("${uri}") or die "${base} is something wrong!";
    #TODO: status code
    my $j = $json->decode($result);
    return $j->{data}{clicks};
}

sub bitly_pro_domain {
    my $self = shift;
    my $domain = shift or return;

    my $uri = URI->new("http://${base}/${SUPPORTED}/bitly_pro_domain");

    $uri->query_form({
        login    => $self->{login},
        apiKey   => $self->{apiKey},
        domain   => $domain,
        format   => 'json',
    });

    warn "[WebService::Bitly] ${uri}\n" if $self->{debug};

    my $result = get("${uri}") or die "${base} is something wrong!";
    #TODO: status code
    my $j = $json->decode($result);
    return !!$j->{data}{bitly_pro_domain};
}

1;
__END__

=head1 NAME

WebService::Bitly -

=head1 SYNOPSIS

  use WebService::Bitly;

=head1 DESCRIPTION

WebService::Bitly is

=head1 AUTHOR

Taiyoh Tanaka E<lt>sun.basix@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
