# Dmr
  Handles defective material reports, will probably be incorporated into another engine at some point but overall application structure hasn't crystalized just yet. 

## Installation
Add this line to your application's gemfile:

```ruby
gem 'dmr', git: 'ttps://github.com/VarlandMetalService/defective-materials'
```

and install:
```bash
$ bundle install
```

add to routes.rb:
```ruby
mount Dmr::Engine => '/dmr'
```
