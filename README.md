# PR review notifier

Elevate github webhooks and integrations with popular messengers to notify 
developers about PRs waiting for the review.

### Getting started

Initialize your database first
```
$ odbcinst -j
$ sqlite3 database.db < init_database.sql
```

### Deploy

Deploy is done with a help of Heroku.
Initialize remote for the first time
```
$ heroku buildpacks:add --index 1 https://github.com/heroku/heroku-buildpack-apt
$ heroku run "sqlite3 database.db < init_database.sql"
$ heroku config:set BASE_URL='https://<your-app-name>.herokuapp.com/'
```

Do not forget to set env variables first in `.env` file or push them manually 
([link](https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application)).

Override config variables for Heroku, e.g. setting custom bot icon
```
$ heroku config:set DEFAULT_SLACK_ICON=':octocat:'
```
