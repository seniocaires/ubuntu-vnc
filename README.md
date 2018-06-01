# Ubuntu VNC

Inicie o container

```
sudo docker run -it --rm --name vnc -e RESOLUCAO=1360x760 -e SENHA=123123 -p 5901:5901 seniocaires/ubuntu-vnc
```

Use o cliente VNC para se conectar ao container

```
java -jar tightvnc-jviewer.jar
```

![alt tag](https://raw.githubusercontent.com/seniocaires/ubuntu-vnc/master/img/vnc-login.jpg)

![alt tag](https://raw.githubusercontent.com/seniocaires/ubuntu-vnc/master/img/vnc-options.jpg)

![alt tag](https://raw.githubusercontent.com/seniocaires/ubuntu-vnc/master/img/linux.jpg)
