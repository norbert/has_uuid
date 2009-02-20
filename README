[has_uuid](http://github.com/tfe/has_uuid/)
========

Provides automated [UUID](http://en.wikipedia.org/wiki/Universally_Unique_Identifier) generation for ActiveRecord objects. UUIDs are created after validations on create. It's also possible to do assignment manually, and some other things (see below). Some configuration options are provided if you want to keep your UUIDs in a column other than "uuid" or if you want to use a different UUID generator (default is to generate version 4 UUIDs).

Depends on the [uuidtools gem](http://github.com/sporkmonger/uuidtools/).

Installation
------------

	script/plugin install git://github.com/tfe/has_uuid.git

Usage
-----
  
	# normal usage
	class Post < ActiveRecord::Base
		has_uuid
	end
	
	# don't auto-assign on create
	class User < ActiveRecord::Base
		has_uuid :auto => false
	end
	
	# store UUID in "token" column, generate version 1 UUIDs
	class User < ActiveRecord::Base
		has_uuid :column => :token, :generator => :timestamp
	end

### Instance Method Usage

	# assigns a UUID if a valid one is not already present
	@post.assign_uuid
	
	# assigns a UUID, replacing whatever is already there
	@post.assign_uuid(:force => true)
	
	# assigns a UUID, replacing whatever was there, and calls save!
	@post.assign_uuid!
  
I'm not sure why you'd use these, but they're there if you want them:

	@post.uuid_valid?
	@post.uuid_invalid?


Credit
------
This was written almost completely by [norbert](http://github.com/norbert/), and I just expanded upon it. [joergbattermann](http://github.com/joergbattermann/) also contributed.


Todo
----

* It would be cool if the plugin included a migration to add the UUID column. Also: a rake task to run the migration on user-specified table(s).  A migration generator would also work and may be better-suited.
* Provide a rake task for easily assigning UUIDs to existing data.
* See [`active_record_uuid`](http://github.com/gabrielg/active_record_uuid/) for examples of the above.

Contact
-------

Problems, comments, and pull requests all welcome. [Find me on GitHub.](http://github.com/tfe/)


----

Modifications copyright (c) 2009 [Todd Eichel](http://toddeichel.com/) for [Fooala, Inc.](http://opensource.fooala.com/), released under the MIT license.

