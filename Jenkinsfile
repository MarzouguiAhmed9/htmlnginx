pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-nginx-app'  // Name for the Docker image
        DOCKER_TAG = 'latest'  // Tag for the Docker image
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
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container (if running)
                    sh 'docker ps -q --filter "name=$DOCKER_IMAGE" | xargs -r docker stop | xargs -r docker rm'

                    // Run the Docker container with the built image
                    sh 'docker run -d -p 8080:80 --name $DOCKER_IMAGE $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }
    }

    post {
        always {
            // Clean up any remaining containers or images, even if the pipeline fails
            sh 'docker ps -q --filter "name=$DOCKER_IMAGE" | xargs -r docker stop | xargs -r docker rm'
            sh 'docker images -q $DOCKER_IMAGE | xargs -r docker rmi'
        }
    }
}
