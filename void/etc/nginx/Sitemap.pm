package Sitemap;
use nginx;
use LWP::Simple;

our $basedir="/usr/local/sitemapnginx/html";

sub handler {
  my $r=shift;
  my $uri=$r->uri;
  $uri=~ s!^/*sitemap/*!!g;
  $uri=~ s!/.*!!g;
  # now $uri has just the domain name such as nginx.com

  my $sitemap_url="http://$uri/sitemap.xml";
  # Get the sitemap from something like http://ispman.net/sitemap.xml (this is dynamic and fresh)

  my $sitemap_data=get($sitemap_url);
  # if the result does not include this string, return 404 Not found.
  return 404 if $sitemap_data !~ m/urlset/;

  # if found, then cache it.
  my $sitemap_file="$basedir/$uri-sitemap.xml";
  open "F", ">$sitemap_file";
  print F $sitemap_data;
  close("F");
  $r->send_http_header("application/xml");
  # return the cached file
  $r->sendfile($sitemap_file);
  $r->flush;
  return OK;
}

1;
