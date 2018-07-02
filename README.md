# XCToken
##### Generate on-demand JWT tokens forAppStore Connect API from Continuous Integration servers 

Apple has announced AppStore Connect API to automate all the task related to Apple Developer Portal as well as iTunes Connect (recently known as AppStore Connect). You can watch WWDC session [303](https://developer.apple.com/videos/play/wwdc2018/303/) to know more about this API. App Store Connect API can now interact with almost all the part of Apple Developer portal including, certificates, profiles and devices. App Store connect API will also touch almost all section of iTunes Connect which is remaned as App Store Connect including manging users and builds. However, this API requires JWT tokens to recieve response. Users needs to create tokens after every 20 minutes. 

XCToken is a Ruby library to generate on-demand tokens for the AppStore Connect API so that we can create tokens using this library without need to write custom scripts on Continuous Integration Servers. 

## Installation

Its unlikely that you iOS  application's has Gemfile and bundler setup but. Just in case you use other Ruby libraries like CocoaPods or Fastlane for managing versions then add this to `Gemfile` :

```ruby
gem 'xctoken'
```

And then execute:

    $ bundle install

Or install it on Continuous Integration Server using following command 

    $ gem install xctoken

## Usage

> Note: At the moment, AppStore Connect API has not released to public Yet nor the AppStore Connect GUI available to experiemnt. So there is no wat to test this library in real world envirnment until Apple release AppStore Connect API to public. 

AppStore Connect API deals with very sensitive information so security is very important aspect. The new AppStore Connect GUI will have ability to generate API KEY and Private Key for API. We should also able to see ISSUER_ID in the AppStore Connect GUI. 

XCToken needs 3 envirnmental varibale setup to secure those credentials. 

 *  `ISSUER_ID` : You can get it from AppStore Connect GUI 
 *  `KEY_DIR` : AppStore Connect has a way to generate private key. We have to keep this key secure and always has associated `KEY_ID` the private key is in the `.p8` format and reads like `AuthKey_KEY_ID.p8`. XCToken requires path to the directory where this private key located. e.g `/tmp` if you have private key at the path `/tmp/Auth_Key_1234.p8` 
 * `KEY_ID` : Every private key has KEY_ID we can set that as envirnment varilable as well 

 On Continuous Integration server, we can secure these credential using Envirnmental Varibale feature of specific CI server. These details shouldn't be exposed or hardcoded. You can enrypt and decrypt the `.p8` format private key on CI server to add extra layer of security. 

 ```
 $ export ISSUER_ID=1234
 $ export KEYDIR=/tmp
 $ export KEY_ID=1234

```

Now that, we all setup to generate the JWT tokens using XCToken by using following simple command. 
```
$ xctoken generate 
```
This will print the fresh token that we can use for the AppStore Connect API. We can run this command every time we need fresh token from CI server. 

## TODO

* Test the library when Apple releases API 
* Add more options to generate token with multiple algorithms and expriry time 
* Ability to use keep token secret rather than printing to console 
* Add more RSpec Tests 



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Shashikant86/xctoken. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Xctoken project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Shashikant86/xctoken/blob/master/CODE_OF_CONDUCT.md).
