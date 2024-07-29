# README

這是把 Docker 當 VM 的用法，單純叫出 ubuntu 18.04 的環境，在 macos ARM64 上可以運行也能安裝 mysql-5.7 環境，並且也設置了 phpmyadmin 的服務。在此使用 php7.2 環境，並且設置了 nginx 服務，包括 http/https 服務等，即可在本地端測試網站功能，並且把現有目錄 mount 到 docker container 上使用。另外，也有安裝 openssh-server 服務，但純粹當作輔助測試用法(ssh tunnel)，大部分 docker 環境上都不會用到

網站服務:

- Website
  - http://localhost
  - https://localhost
- phpMyAdmin
  - http://localhost:8080
  - http://localhost:8443

其中預設有一組 DB 帳密 developer / developer 可以登入，並且有個資料庫名為 developer 可以使用，可在 phpmyadmin 服務上，把 db.sql 匯入即可。

---

# Build Docker Image

```
% docker build -t ubuntu18.04-phpmyadmin-php7.2-mysql-5.7 .
```

# Run

```
% docker run -p 80:80 -p 443:443 -p 8080:8080 -p 8443:8443 -v ./my-website-code:/var/www/my-website ubuntu18.04-phpmyadmin-php7.2-mysql-5.7
 * Starting MySQL database server mysqld
   ...done.
 * Starting OpenBSD Secure Shell server sshd
   ...done.
 * Starting nginx nginx
   ...done.
```

# Access

`docker exec -it <container-id> /bin/bash`

```
CONTAINER ID   IMAGE                                    COMMAND                   CREATED         STATUS         PORTS                                                              NAMES
123454321   ubuntu18.04-phpmyadmin-php7.2-mysql-5.7   "/usr/local/bin/entr…"   2 minutes ago   Up 2 minutes   0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp, 0.0.0.0:3306->3306/tcp   zealous_lamarr
% docker exec -it 123454321 /bin/bash
root@123454321:/# 
```

# Stop

```
% docker ps
CONTAINER ID   IMAGE                                    COMMAND                   CREATED         STATUS         PORTS                                                              NAMES
123454321   ubuntu18.04-phpmyadmin-php7.2-mysql-5.7   "/usr/local/bin/entr…"   2 minutes ago   Up 2 minutes   0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp, 0.0.0.0:3306->3306/tcp   zealous_lamarr
%
% docker stop 123454321
```
