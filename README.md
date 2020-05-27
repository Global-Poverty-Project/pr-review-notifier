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

Create repository for application image

```bash
$ aws ecr create-repository --repository-name prn
```

Build image locally and push to the remote repository

```bash
$ aws ecr get-login-password \
    --region us-east-1 | docker login \
    --username AWS \
    --password-stdin 457398059321.dkr.ecr.us-east-1.amazonaws.com/prn
$ docker build -t prn .
$ docker tag prn:latest 457398059321.dkr.ecr.us-east-1.amazonaws.com/prn:latest
$ docker push 457398059321.dkr.ecr.us-east-1.amazonaws.com/prn:latest
```

### Customization

Update channel to which messages will be delivered

```bash
$ aws ssm put-parameter --name "PRN_DEFAULT_SLACK_CHANNEL" --value "#notifications" \
    --type "String" --overwrite
```

Update bot icon

```bash
$ aws ssm put-parameter --name "PRN_DEFAULT_SLACK_ICON" --value ":male-detective:" \
    --type "String" --tags "Key=app,Value=prn"
```

### Troubleshooting

* Check [logs on CloudWatch](https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logStream:group=prn)
