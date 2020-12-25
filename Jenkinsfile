pipeline {
    agent {
        label 'ubuntu_ec2'
    }
    stages {
        stage('Prepare') {
            steps {
                sh 'sudo apt-get update && sudo apt-get install -y docker-compose'
            }
        }
        stage('Build') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'S3']]) {
                    sh """sudo sh -c \
                        'export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} &&
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} &&
                        cd ci && ./run-ci.sh'"""
                }
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
