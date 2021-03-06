# RailsAdminInvite
Super easy and flexible way to provide an invitation view and logic in
[rails_admin](https://github.com/sferik/rails_admin).

## ATTENTION
In your Gemfile you must define `rails_admin` **after** `rails_admin_invite`.

## Usage
In your rails_admin initializer (config/initializers/rails_admin.rb):

```ruby
  config.actions do
    # usual actions here
    invite do
      # here goes a set of models which should be "invitable", like this:
      only [User, Admin]
      # or this:
      only User
    end
  end

  config.model User do
    # your User model-specific configs here
    invite do
      # set of fields you want here
      # (all included by default, these settings will overwrite the defaults)
      field :full_name
      field :email
      field :phone
      # at the following available callbacks you can specify
      # any invitation related logic you want
      before_save [(proc do |user, shared_hash|
        shared_hash[:password] = SecureRandom.hex(4)
        user.password = shared_hash[:password]
      end)]
      after_save [(proc do |user, shared_hash|
        UserMailer.invitation_letter(user, shared_hash[:password]).deliver
      end)]
    end
  end
```

Note that ugly callback syntax... :poop: I hope I will be able to avoid it soon...

Refer to [rails_admin](https://github.com/sferik/rails_admin) to find out more about configuration.

## Installation
**Note:** in your Gemfile you must define `rails_admin` **after** `rails_admin_invite`.

Add this line to your application's Gemfile:

```ruby
gem 'rails_admin_invite', github: 'FunkyloverOne/rails_admin_invite'
gem 'rails_admin'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_admin_invite
```

## Contributing
As usual - fork and make PR's.

The gem is not covered with tests yet. Feel free to provide PR's with tests :D

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
