has_uuid
========

[has_uuid](http://github.com/norbert/has_uuid) provides basic [UUID](http://en.wikipedia.org/wiki/Universally_Unique_Identifier) assignment methods for ActiveRecord objects.

It depends on the [uuidtools](http://uuidtools.rubyforge.org/) gem.


Installation
------------

	script/plugin install git://github.com/norbert/has_uuid.git


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


Credits
-------

* Norbert Crombach
* Todd Eichel
* Joerg Batterman
