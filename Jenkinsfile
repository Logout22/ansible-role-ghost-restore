pipeline {
    agent none

    stages {
        stage('Prepare') {
            agent { 
                label 'ubuntu_ec2'
            }
            steps {
                sh 'sudo apt-get update && sudo apt-get install -y docker-compose'
            }
        }
        stage('Build') {
            agent { 
                label 'ubuntu_ec2'
            }
            steps {
                sh 'cd travis && sudo ./prepare.sh'
            }
        }
    }
}
/*
  - distribution: debian
    version: buster
  - distribution: ubuntu
    version: bionic
  - distribution: ubuntu
    version: focal */
