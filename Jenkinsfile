pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'docker.io'                          // Docker registry URL for Docker Hub
        DOCKER_IMAGE = 'gandhinagar/cicdtest'                  // Your DockerHub public repository name
        DOCKER_CREDENTIALS_ID = 'bc959098-797a-410e-9eed-355ecf7974fe'  // Jenkins credentials ID for Docker registry
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the code...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building Docker image...'
                script {
                    // Build the Docker image from the Dockerfile in the repository
                    docker.build("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }
        
        stage('Upload to Docker Registry') {
            steps {
                echo 'Pushing Docker image to the registry...'
                script {
                    // Log in to Docker registry
                    docker.withRegistry("https://${DOCKER_REGISTRY}", "${DOCKER_CREDENTIALS_ID}") {
                        // Push the Docker image
                        docker.image("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up Docker images...'
            sh "docker rmi ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${env.BUILD_ID} || true"
        }
    }
}
