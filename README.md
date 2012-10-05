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

Heroku Cedar stack comes with the following goodies:

* Ubuntu 10.04
* MRI 1.9.2
* Node.js
* Clojure
* Java
* Python
* Scala
* Nginx + Passenger (setup for Ruby on Rails apps only)

Your dev box will be configured with all of the above. What it will
**NOT** have is the Heroku post commit hooks which deploy your app for
you.
