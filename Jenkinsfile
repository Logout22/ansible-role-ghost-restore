pipeline {
    agent {
        label 'ubuntu_ec2'
    }
    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20', artifactNumToKeepStr: '20'))
    }
    stages {
        stage('Prepare') {
            steps {
                sh 'git submodule update --init --recursive'
            }
        }
        stage('Build') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'S3']]) {
                    sh '''sudo sh -c \
                        "export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} && \
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} && \
                        cd restore_ci && ./run-ci.sh 2220"'''
                }
            }
        }
    }
    post {
        always {
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                     to: "martin.u@posteo.de",
                     subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
        }
    }
}
