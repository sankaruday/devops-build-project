pipeline {
    agent any
    
    environment {
        DOCKER_USER = 'uday2097'
        DOCKER_HUB_CREDS = credentials('dockerhub_creds')
        // This helper identifies the branch name even in standard pipelines
        CURRENT_BRANCH = "${env.GIT_BRANCH}".replace('origin/', '')
    }

    stages {
        stage('Login to Docker Hub') {
            steps {
                // Using single quotes for the shell command to prevent Groovy interpolation of secrets
                sh 'echo $DOCKER_HUB_CREDS_PSW | docker login -u $DOCKER_HUB_CREDS_USR --password-stdin'
            }
        }

        stage('Build & Push') {
            steps {
                script {
                    if (env.CURRENT_BRANCH == 'dev') {
                        echo "Building and Pushing to Development Repository..."
                        sh "docker build -t $DOCKER_USER/dev:latest ."
                        sh "docker push $DOCKER_USER/dev:latest"
                    } 
                    else if (env.CURRENT_BRANCH == 'main' || env.CURRENT_BRANCH == 'master') {
                        echo "Building and Pushing to Production Repository..."
                        sh "docker build -t $DOCKER_USER/prod:latest ."
                        sh "docker push $DOCKER_USER/prod:latest"
                    }
                    else {
                        echo "Branch ${env.CURRENT_BRANCH} detected. No push logic defined for this branch."
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Only deploy if the build was successful
                sh "chmod +x deploy.sh"
                sh "./deploy.sh"
            }
        }
    }

    post {
        always {
            // Clean up workspace and images to prevent "No space left on device" errors again
            cleanWs()
            sh "docker image prune -f"
        }
    }
}
