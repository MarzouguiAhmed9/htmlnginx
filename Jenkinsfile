pipeline {
    agent any  // Specify the type of agent to run the pipeline (could be 'docker', 'node', etc.)

   

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile
                    sh 'docker build -t "myimage"  .'
                }
            }
        }

        stage('Run Nginx Container') {
            steps {
                script {
                    // Run Docker container with Nginx
                    sh 'docker run -d -p 80:80 myimage'
                    
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker resources after build
            script {
                sh 'docker system prune -f'  // Remove unused Docker resources
            }
        }
    }
}
