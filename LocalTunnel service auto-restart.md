
Si vous utilisez CentOS, vous pouvez installer et configurer supervisord en suivant les étapes ci-dessous :

Installez supervisord et localtunnel en utilisant le commande suivante :

    sudo yum install -y epel-release supervisor npm
    sudo npm install -g localtunnel

Créez un fichier de configuration pour votre travail dans le répertoire `/etc/supervisord.d/`. Par exemple, vous pouvez créer un fichier `deployeur.ini` avec le contenu suivant :

    [program:jenkins-lab]
    command=lt --port 8080 --subdomain jenkins-lab
    autostart=true
    autorestart=true
    stderr_logfile=/var/log/jenkins-lab.err.log
    stdout_logfile=/var/log/jenkins-lab.out.log
    
    [program:dimension-staging]
    command=lt --port 81 --subdomain dimension-staging
    autostart=true
    autorestart=true
    stderr_logfile=/var/log/dimension-staging.err.log
    stdout_logfile=/var/log/dimension-staging.out.log
    
    [program:dimension-production]
    command=lt --port 82 --subdomain dimension-production
    autostart=true
    autorestart=true
    stderr_logfile=/var/log/dimension-production.err.log
    stdout_logfile=/var/log/dimension-production.out.log

Ce fichier de configuration spécifie que supervisord doit lancer les commandes "`lt`" en arrière-plan et redémarrer automatiquement le processus en cas de panne.

Faite lancer supervisord au démarrage :

    sudo systemctl enable supervisord

Enregistrez et redémarrez supervisord pour prendre en compte la nouvelle configuration :

    sudo systemctl restart supervisord

Après avoir effectué ces étapes, votre travail devrait être en cours d'exécution en permanence en arrière-plan et supervisé par supervisord. Vous pouvez également consulter les journaux de sortie pour vérifier si votre travail est en cours d'exécution et pour diagnostiquer les éventuels problèmes en cas de panne.