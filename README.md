README
======

Dev Setup
---------

Ruby && Rails:  
- ```rbenv install```
- ```gem install bundler```
- ```bundle```
- ```cp .env.example .env```

Database:  
- ```rake db:drop && rake db:create && rake db:migrate && rake db:seed```
- ```rake import:pastorscoop && rake import:church_database```
