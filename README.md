Heroku Dev Box
==============

Heroku Dev Box is a Vagrant box with the Heroku Cedar stack provisioned
via Puppet

Usage
========

    git clone git@github.com:pastafari/heroku-dev-box.git
    cd heroku-dev-box
    vagrant up
    vagrant ssh

That's it. You should have a Vagrant box up and running with all the
goodies that come with a heroku-dev-box stack.

Details
========

The [Heroku Cedar stack](https://devcenter.heroku.com/articles/cedar) comes with the following goodies:

* Ubuntu 10.04
* Ruby MRI 1.9.2
* Node.js
* Postgresql
* Clojure
* Java
* Python
* Scala


**The first cut of heroku-dev-box comes with support for Ruby and Node.js.
Hopefully we can add the rest of the stack soon.**

Your dev box will be configured with all of the above. What it will
**NOT** have is the Heroku post commit hooks which deploy your app for
you.
