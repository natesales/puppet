# == Class web
#
# Installs the web repo.
#
class profile::web(
){
    include ::profile::autopip
    include apache
 
    git::clone { 'MirahezeBots/mirahezebots.org':
        ensure    => 'latest',
        directory => '/var/flask',
        branch    => 'dev',
        owner     => www-data,
        group     => www-data,
        recurse_submodules => true,
    }
    file { 'post-flask-hook':
        ensure  => file,
        path    => '/var/flask/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-flask',
        mode    => '0755',
        owner   => www-data,
        group   => www-data,
    }
    file { 'flask-config':
        ensure  => file,
        path    => '/var/flask/config.json',
        source  => 'puppet:///modules/profile/webconfig.json',
        mode    => '0755',
        owner   => www-data,
        group   => www-data,
    }
    file { 'flask-wsgi':
        ensure  => file,
        path    => '/var/flask/mhbots.wsgi',
        source  => 'puppet:///modules/profile/mhbots.wsgi',
        mode    => '0755',
        owner   => www-data,
        group   => www-data,
    }
}
