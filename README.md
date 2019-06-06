# Defective Materials
  Handles defective material reports, will probably be incorporated into another engine at some point but overall application structure hasn't crystalized just yet. 

## Installation
Add this line to your application's gemfile:

```ruby
gem 'dmr', git: 'https://github.com/VarlandMetalService/defective-materials'
```

and install:
```bash
$ bundle install
```

add to routes.rb:
```ruby
mount Dmr::Engine => '/dmr'
```
