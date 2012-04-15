[![Build Status](https://secure.travis-ci.org/troessner/has_uuid.png)](http://travis-ci.org/troessner/has_uuid)

has_uuid
========

[has_uuid](http://github.com/troessner/has_uuid) provides basic [UUID](http://en.wikipedia.org/wiki/Universally_Unique_Identifier) assignment methods for ActiveRecord objects.

It depends on the [uuidtools](http://uuidtools.rubyforge.org/) gem.

This is a fork - full credits for the source code go to [has_uuid](http://github.com/norbert/has_uuid).

What I changed:

a) Made it rails 3.1 compatible.

b) Bundler'ized it - you can now use and manage it as a gem, not as a rails plugin.

c) Added generate_uuid as a class method

Installation
------------

Add

>> gem 'has_uuid'

to your Gemfile and run

>> bundle install

Usage
-----

	class Post < ActiveRecord::Base
	  # automatically assign a UUID to the "uuid" column on create
	  has_uuid
	end

	class Comment < ActiveRecord::Base
	  # skip assignment on create
	  has_uuid :auto => false
	end

	class User < ActiveRecord::Base
	  # store the UUID in the "token" column, generate version 1 UUIDs
	  has_uuid :column => :token, :generator => :timestamp
	end

	# assign a UUID if a valid one is not already present
	@post.assign_uuid

	# assign a UUID, replacing whatever is already there
	@post.assign_uuid(:force => true)

	# assign a UUID and save, replacing whatever is there
	@post.assign_uuid!

	# check if the current UUID is valid
	@post.uuid_valid?

	# Generate a UUID to use it later
	Post.generate_uuid

Credits
-------

* Norbert Crombach
* Todd Eichel
* Joerg Batterman
