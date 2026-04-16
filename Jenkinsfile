pipeline {
    agent any
    environment {
        DOCKER_USER = 'uday2097'
        DOCKER_HUB_CREDS = credentials('dockerhub_creds') 
    }
    stages {
        stage('Login to Docker Hub') {
            steps {
                sh "echo $DOCKER_HUB_CREDS_PSW | docker login -u $DOCKER_HUB_CREDS_USR --password-stdin"
            }
        }
        stage('Build & Push') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        echo "Processing Dev Branch..."
                        sh "./build.sh" // Uses your existing script
                        sh "docker tag $DOCKER_USER/dev:latest $DOCKER_USER/dev:latest"
                        sh "docker push $DOCKER_USER/dev:latest"
                    } 
                    else if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') {
                        echo "Processing Master Branch..."
                        sh "docker build -t $DOCKER_USER/prod:latest ."
                        sh "docker push $DOCKER_USER/prod:latest"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh "./deploy.sh"
            }
        }
    }
}
