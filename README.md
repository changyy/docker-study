# Others

- [osticket-study](https://github.com/changyy/osticket-study)

---

# macOS

```bash
% uname -mopr
Darwin 23.5.0 arm64 arm

% sw_vers 
ProductName:		macOS
ProductVersion:		14.5
BuildVersion:		23F79

% echo $SHELL
/bin/zsh
```

## MacPorts

```bash
% port version
Version: 2.9.3
```

## PHP

```bash
% date
2024年 7月29日 週一 23時34分06秒 CST
% sudo port search php83
...
Found 81 ports.

% sudo port install php83 php83-iconv php83-intl php83-mbstring php83-openssl php83-curl php83-sqlite php83-xml php83-zip
```

## PHP Composer

```bash
% alias php=php83
% wget https://getcomposer.org/download/latest-stable/composer.phar -O /tmp/composer.phar
% php /tmp/composer.phar self-update
You are already using the latest available Composer version 2.7.7 (stable channel).
% php /tmp/composer.phar --version
% php /tmp/composer.phar --version
Composer version 2.7.7 2024-06-10 22:11:12
PHP version 8.3.9 (/opt/local/bin/php83)
Run the "diagnose" command to get more detailed diagnostics output.
```

## A Laravel Project with PHP Composer

```bash
% php /tmp/composer.phar create-project laravel/laravel /tmp/laravel-project
Creating a "laravel/laravel" project at "/tmp/laravel-project"
Installing laravel/laravel (v11.1.4)
  - Installing laravel/laravel (v11.1.4): Extracting archive
Created project in /tmp/laravel-project
> @php -r "file_exists('.env') || copy('.env.example', '.env');"
Loading composer repositories with package information
Updating dependencies
...
```

### Start Laravel Server

```bash
% cd /tmp/laravel-project 
laravel-project % php artisan serv

   INFO  Server running on [http://127.0.0.1:8000].  

  Press Ctrl+C to stop the server
```
