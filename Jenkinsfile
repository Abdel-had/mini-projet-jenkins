pipeline {
    environment {
        IMAGE_NAME = "dimension"
        IMAGE_TAG = "latest"
        STAGING = "dimension-staging"
        PRODUCTION = "dimension-production"
        COMPANY_NAME = "dimension"
        REGISTRY_DOMAIN = "registry.loca.lt"
    }

    agent any

    stages {
        stage('Build image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }
        stage('Run container') {
            steps {
                sh '''
                    docker container prune -f
                    docker ps -a | grep -i ${IMAGE_NAME} && docker rm -f ${IMAGE_NAME}
                    docker run -d -p 83:80 --name ${IMAGE_NAME} ${IMAGE_NAME}:${IMAGE_TAG}
                    sleep 5
                '''
            }
        }
        stage('Test application') {
            steps { 
              sh '''
              # export VAGRANT_HOST_IP=$(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')
              curl http://192.168.56.13:83 | grep -q 'Hello world!'
              '''
            }
        }
        stage('Clean environment') {
            steps {
                sh 'docker rm -f ${IMAGE_NAME}'
            }
        }
        stage('Push image') {
            when {
                expression { GIT_BRANCH == 'origin/master' }
            }
            steps {
                // Appelle la fonction partagée pushImage avec les variables nécessaires
                pushImage(REGISTRY_DOMAIN, COMPANY_NAME, IMAGE_NAME, IMAGE_TAG)
            }
        }
        stage('Remove docker cache') {
            when {
                expression { GIT_BRANCH == 'origin/master' }
            }
            steps {
                sh 'docker image prune -af'
            }
        }
        stage('Deploy staging app') {
            when {
                expression { GIT_BRANCH == 'origin/master' }
            }
            steps {
                sh '''
                    docker ps -a | grep -i ${STAGING} && docker rm -f ${STAGING}
                    docker run -d -p 81:80 --name ${STAGING} ${REGISTRY_DOMAIN}/${COMPANY_NAME}/${IMAGE_NAME}:${IMAGE_TAG}
                    sleep 10
                '''
            }
        }
        stage('Check staging app') {
            when {
                expression { GIT_BRANCH == 'origin/master' }
            }
            steps {
                sh 'curl https://${STAGING}.loca.lt | grep -q "Hello world!"'
            }
        }
        stage('Deploy production app') {
            when {
                expression { GIT_BRANCH == 'origin/master' }
            }
            steps {
                sh ''' 
                    docker ps -a | grep -i ${PRODUCTION} && docker rm -f ${PRODUCTION}
                    docker run -d -p 82:80 --name ${PRODUCTION} ${REGISTRY_DOMAIN}/${COMPANY_NAME}/${IMAGE_NAME}:${IMAGE_TAG}
                    sleep 20 
                '''
            }
        }
        stage('Check production app') {
            when {
                expression { GIT_BRANCH == 'origin/master' }
            }
            steps {
                sh 'curl https://${PRODUCTION}.loca.lt | grep -q "Hello world!"'
            }
        }
    }
    post {
        always {
            script {
                // Appelle la fonction partagée slackNotifier avec le résultat de la construction.
                slackNotifier(currentBuild.result)
            }
        }
    }
}