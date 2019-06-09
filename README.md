# PR review notifier

![octobot](icon.png)

Elevate github webhooks and integrations with popular messengers to notify 
developers about PRs waiting for the review.

### Testing

Create `config_local.py` with settings overrides, install dependencies and run 
app via

```bash
$ poetry install
$ poetry run python app.py
```

You can simulate requests from github like this

* PR was labeled

```bash
$ curl -v -H "Content-Type: application/json" \
    --data @test/payload_labeled.json http://localhost:8080/payload
```

* PR was approved

```bash
$ curl -v -H "Content-Type: application/json" \
    --data @test/payload_submitted.json http://localhost:8080/payload
```

### Dockerized app

Image is based on [Apline Linux](https://alpinelinux.org/).


### Deploy



### Customization

Override config variables for Heroku, e.g. setting custom bot icon

```bash
$ heroku config:set DEFAULT_SLACK_ICON=':octocat:'
```

### Troubleshooting

Useful commands to figure out what's going wrong

```bash
$ heroku logs  # show process output
$ heroku restart  # restart application on remote
$ heroku run bash  # login to the remote shell
$ heroku buildpacks:remove heroku/nodejs  # remove unused buildpack
```
