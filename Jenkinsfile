pipeline {
    agent any
    
    environment {
        DOCKER_USER = credentials('bc959098-797a-410e-9eed-355ecf7974fe') // Jenkins credential ID for Docker username
        DOCKER_PASS = credentials('bc959098-797a-410e-9eed-355ecf7974fe') // Jenkins credential ID for Docker password
        DOCKER_IMAGE = 'gandhinagar/nodejstest' // Replace with your Docker ID and image name
        DOCKER_REGISTRY = 'https://registry-1.docker.io' // Docker Hub URL
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_ID} ."
                }
            }
        }
        
        stage('Login to Docker Registry') {
            steps {
                script {
                    // Login to Docker Registry (Docker Hub)
                    sh "echo ${DOCKER_PASS} | docker login ${DOCKER_REGISTRY} -u ${DOCKER_USER} --password-stdin"
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Push Docker image
                    sh "docker push ${DOCKER_IMAGE}:${env.BUILD_ID}"
                }
            }
        }
        
        stage('Cleanup') {
            steps {
                script {
                    // Cleanup Docker images from local
                    sh "docker rmi ${DOCKER_IMAGE}:${env.BUILD_ID}"
                }
            }
        }
    }
    
    post {
        always {
            // Logout of Docker Registry
            sh "docker logout ${DOCKER_REGISTRY}"
        }
    }
}
