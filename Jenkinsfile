pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-nginx-app'  // Name for the Docker image
        DOCKER_TAG = 'latest'  // Tag for the Docker image
        DOCKER_HOST = 'tcp://localhost:2375'  // Docker Desktop Docker daemon URL (Make sure Docker Desktop is set to expose the daemon)
    }

    stages {
        stage('Checkout Repository') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image from the Dockerfile
                script {
                    sh '''
                    export DOCKER_CLI_EXPERIMENTAL=enabled
                    docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
                    '''
                }
            }
        }

        stage('Run f Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container (if running)
                    sh '''
                    docker ps -q --filter "name=$DOCKER_IMAGE" | xargs -r docker stop | xargs -r docker rm
                    '''

                    // Run the Docker container with the built image
                    sh '''
                    docker run -d -p 8085:80 --name $DOCKER_IMAGE $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
    }
}
