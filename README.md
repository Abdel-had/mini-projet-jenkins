# mini-projet-jenkins
Eazytraining Bootcamp DevOps promo 12 : mini-projet sur la formation Jenkins

docker exec jenkins mkdir /var/jenkins_home/jobs/dimension
docker cp /home/vagrant/mini-projet-jenkins/jenkins-job/config.xml jenkins:/var/jenkins_home/jobs/dimension/
docker cp /home/vagrant/mini-projet-jenkins/jenkins-settings/config.xml jenkins:/var/jenkins_home/