trellhub [![Dependency Status](https://gemnasium.com/SalesLoft/trellhub.png)](https://gemnasium.com/SalesLoft/trellhub) [![Code Climate](https://codeclimate.com/github/SalesLoft/trellhub.png)](https://codeclimate.com/github/SalesLoft/trellhub)
=======

A webhook service for Github <-> Trello integration.

Usage
-----

Currently, the system only supports mentioning a commit inside of Trello cars. To do so, inside of any commit message simply tag it using the following format:

    tr#<card number>

So, you would use ```tr#123``` to mention your commit in card 123. 
