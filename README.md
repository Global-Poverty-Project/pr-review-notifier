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
$ $(aws ecr get-login --no-include-email --region us-west-1)
$ docker build -t prn .
$ docker tag prn:latest 457398059321.dkr.ecr.us-west-1.amazonaws.com/prn:latest
$ docker push 457398059321.dkr.ecr.us-west-1.amazonaws.com/prn:latest
```

### Deploy

Push required environment variables to [SSM](https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html)

```bash
$ aws ssm put-parameter --name "PRN_OWNER_NAME" --value "<owner-name>" \
    --type "String" --tags "Key=app,Value=prn"
$ aws ssm put-parameter --name "PRN_REPO_NAME" --value "<repository-name>" \
    --type "String" --tags "Key=app,Value=prn"
$ aws ssm put-parameter --name "PRN_GITHUB_ACCESS_TOKEN" --value "<github-access-token>" \
    --type "String" --tags "Key=app,Value=prn"
$ aws ssm put-parameter --name "PRN_GITHUB_CLIENT_ID" --value "<github-client-id>" \
    --type "String" --tags "Key=app,Value=prn"
$ aws ssm put-parameter --name "PRN_GITHUB_CLIENT_SECRET" --value "<github-client-secret>" \
    --type "String" --tags "Key=app,Value=prn"
$ aws ssm put-parameter --name "PRN_SLACKBOT_TOKEN" --value "<slackbot-token>" \
    --type "String" --tags "Key=app,Value=prn"
$ aws ssm put-parameter --name "PRN_DEFAULT_SLACK_CHANNEL" --value "<slack-channel>" \
    --type "String" --tags "Key=app,Value=prn"
```

### Customization

Update channel to which messages will be delivered

```bash
$ DEFAULT_SLACK_ICON=':octocat:'
```

Update bot icon

```bash
$ 
```

### Troubleshooting


