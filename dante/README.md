Dante - A free SOCKS server with authentication
===========================

[Dante][1] is a product developed by Inferno Nettverk A/S. It consists of a
SOCKS server and a SOCKS client, implementing RFC 1928 and related standards.
It is a flexible product that can be used to provide convenient and secure
network connectivity. 

## docker-compose.yml

```
dante:
  image: cpfd/dante
  ports:
    - "1080:1080"
  volumes:
    - ./sockd.conf:/etc/sockd.conf
  restart: always
  env:
    PROXY_USERNAME: user
    PROXY_PASSWORD: secret
```

## sockd.conf

```
debug: 0
logoutput: stderr
internal: 0.0.0.0 port = 1080
external: eth0
socksmethod: username 
clientmethod: none
user.privileged: root
user.unprivileged: nobody

client pass {
    from: 0.0.0.0/0 port 1-65535 to: 0.0.0.0/0
    log: error
}

socks pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    #socksmethod: username
    log: error
}
```

## quick dante server from command line

```
$ docker run -d --name dante -p 1080:1080 -e PROXY_USER=user -e PROXY_PASSWORD=secret cpfd/dante


$ curl --proxy socks5://user:secret@localhost:1080 http://ip.jsontest.com
```

[1]: http://www.inet.no/dante/index.html
