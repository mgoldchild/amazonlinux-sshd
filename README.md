## docker-amazonlinux-sshd

serve only one connection and will be shutdown after session closed.

build

```
$ docker build -t amazonlinux-sshd:latest .
```

run

```
$ docker run --rm -p 10022:22 -e ROOT_PW=password_to_login  -t amazonlinux-sshd:latest
```

## ENV

- `ROOT_PW`: password for root login (default: `rooooot`)


## REFERENCES:
- https://qiita.com/takeshi_miyajim/items/92a525e6beddd438c76b
- https://docs.docker.com/engine/examples/running_ssh_service/
- https://github.com/sawanoboly/amazonlinux-sshd
