# my nvim config in docker for remote servers

## script

```bash
docker build -t nv .
docker run -t --rm -v $(pwd):/home/dev/workspace nv .
```

## or docker-compose.yml
```yaml
version: '3'
services:
    nvim:
        build: .
        volumes:
            - [SERVER_PATH]:/home/dev/workspace
        tty:true
        stdin_open: true
```
```bash
docker-compose up
```
