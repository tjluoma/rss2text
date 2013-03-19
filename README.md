rss2text
========

Some code snippets that I'm working on to process RSS content.

## 2013-03-18

With the impending demise of Google Reader, I am looking for a replacement for RSS feed reading, but I'm also looking to alleviate some long-standing problems and frustrations I've had with some RSS feeds that I follow.

* Inability to filter based on content

* Truncated RSS feeds (even for some sites where I may for access)

* full text search (especially w/r/t truncated RSS Feeds)

The goal of this project is *not* to help subvert any website which offers full-text RSS feeds for subscribers. If you like the site enough to want a full text feed and they offer that, you should subscribe. However, I subscribed to Macworld's "Insider" program in order to get full text RSS feeds, but they still ended the program because of lack of interest.  Now they only offer partial RSS feeds.

There are some sites, such as the [Daring Fireball Linked List] and [OneThingWell], where the RSS feed, even a full-text RSS feed, doesn't really get me what I want, because it's the sites that they are linking to that I am probably interested in.

### Breadcrumbs

I'm not sure that I'll end up releasing the finished version of everything I do, because I don't want to get under anyone's skin for this.  Mostly it's a place for me to document what I'm doing so that I might remember it in 6 months.

## Step 1: Caching ##

The first thing that I realized when I started this project was that I needed to have a centralized 'cache' of URLs that I had processed. That way I wouldn't waste CPU time (mine or theirs) by reprocessing the same page more than once. (Of course this means that if someone edits a page and makes a change to it, I might not see the changes. Them's the breaks.)

Right now the cache file is just a flat file with URLs in it, which is stored at `~/Dropbox/etc/rss2email.cache.txt`. That way the cache file is available on any Mac that I might use.

## Step 2: One script per site ##

My original vision was to create a shell script which would process any/all RSS feeds and do what I want with the result.

I quickly realized that was stupid, for several reasons:

1.	I want to do different things with different feeds

2.	Creating _functions_ which are generalized enough to work in many places is very difficult, especially when I realize on 'Site #10' that I need to tweak something that I wrote for 'Site #2'. Will changing this to work here break that over there? It's much easier, in the long term, to copy existing code that I have created and then modify it where needed.

3.	If processing a specific site fails, I don't want it to take down anything else.

4.	Some sites might need to be processed several times a day, some once a day, some one a week. If a site is only updated a few times a month there's no sense fetching and parsing its RSS feed every hour.

## Get `lynx` and `wget` ##

`curl` comes with Mac OS X but `wget` and `lynx` do not. They are both far too useful to ignore just because they don't come standard. Get them from [Homebrew] or [Rudix] if you don't have them already.

## "This would be so much easier in perl/ruby/python!" ##

I'm sure it would, but I don't know perl/ruby/python. This is what I know.


[Rudix]: http://rudix.org/
[Homebrew]: http://mxcl.github.com/homebrew/
[Daring Fireball Linked List]: http://daringfireball.net/linked/
[OneThingWell]: http://onethingwell.org