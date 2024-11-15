pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-nginx-app'  // Name for the Docker image
        DOCKER_TAG = 'latest'  // Tag for the Docker image
        DOCKER_HOST = 'tcp://localhost:8444'  // Docker Desktop Docker daemon URL (Make sure Docker Desktop is set to expose the daemon)
    }

    stages {
        stage('Checkout Repository') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    export DOCKER_CLI_EXPERIMENTAL=enabled
                    docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh '''
                    docker ps -q --filter "name=$DOCKER_IMAGE" | xargs -r docker stop | xargs -r docker rm
                    docker run -d -p 8085:80 --name $DOCKER_IMAGE $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
    }
}
