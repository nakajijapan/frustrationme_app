# www.frustration.me

[![Build Status](https://api.travis-ci.org/nakajijapan/frustrationme_app.png?branch=master)](http://travis-ci.org/nakajijapan/frustrationme_app)
[![Coverage Status](https://coveralls.io/repos/nakajijapan/frustrationme_app/badge.png?branch=master)](https://coveralls.io/r/nakajijapan/frustrationme_app?branch=master)

## What is this?

Social Wishlist Service.

![www.frustration.me](https://raw.github.com/nakajijapan/frustrationme_app/master/app/assets/images/icon500_500.png)

## How to use

### development

* setting api

```
mv  config/secret_skel.rb config/secret.rb
vim config/secret_skel.rb
```

* isntall gems

```
bundle install
```

* start unicorn

```
bundle exec unicorn -c config/unicorn.rb -l 5000
```

## Test

```
bundle exec rspec spec
```