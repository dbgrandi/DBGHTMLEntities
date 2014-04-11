##(NOTE: This is PRE-RELEASE until I finish a few things and push the Podspec)

# DBGHTMLEntities

[![Version](http://cocoapod-badges.herokuapp.com/v/DBGHTMLEntities/badge.png)](http://cocoadocs.org/docsets/DBGHTMLEntities)
[![Platform](http://cocoapod-badges.herokuapp.com/p/DBGHTMLEntities/badge.png)](http://cocoadocs.org/docsets/DBGHTMLEntities)

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

Or, for the easiest, run `pod try DBGHTMLEntities`

To do a simple string decode:

``` objc
NSString *encodedString = @"Texas A&amp;M needs decoding.";
DBGHTMLEntityDecoder *decoder = [[DBGHTMLEntityDecoder alloc] init];
NSString *decodedString = [decoder decodeString:encodedString];
```

If you have an NSMutableString you can decode in place using:

``` objc
NSMutableString *encodedString = @"OH: &quot;Parse all the strings!&quot;";
DBGHTMLEntityDecoder *decoder = [[DBGHTMLEntityDecoder alloc] init];
[decoder decodeStringInPlace:encodedString];
```

The second method, `decodeStringInPlace:` was created explicitly for an issue I had while manipulating NSAttributedStrings to show Tweets with highlighted hashtags, user mentions, and proper URLs based on the [Tweet entities](https://dev.twitter.com/docs/entities). I ended up setting up highlighting attributes on parts of an `NSMutableAttributedString` and then calling `decodeStringInPlace:`

``` objc
NSMutableAttributedString *tweetString = ...

// highlight user_mentions
// highlight hashtags
// replace urls

DBGHTMLEntityDecoder *decoder = [[DBGHTMLEntityDecoder alloc] init];
[decoder decodeStringInPlace:tweetString.mutableString];

tweetLabel.attributedText = tweetString;
```

## Installation

DBGHTMLEntities is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "DBGHTMLEntities"

## Author

[David Grandinetti](http://twitter.com/dbgrandi), dbgrandi@gmail.com

## Inspiration

This was essentially a lazy port from the [htmlentities](https://github.com/threedaymonk/htmlentities) RubyGem by [Paul Battley](https://github.com/threedaymonk). Paul did a much better job of (optionally) supporting the expanded set of HTML Entity
strings as well as the pretty essential funtion of encoding.

## License

DBGHTMLEntities is available under the MIT license. See the LICENSE file for more info.

