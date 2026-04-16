pipeline {
    agent any
    
    environment {
        DOCKER_USER = 'uday2097'
        DOCKER_HUB_CREDS = credentials('dockerhub_creds')
    }

    stages {
        stage('Login') {
            steps {
                sh 'echo $DOCKER_HUB_CREDS_PSW | docker login -u $DOCKER_HUB_CREDS_USR --password-stdin'
            }
        }

        stage('Force Push to Prod') {
            steps {
                script {
                    echo "FORCING PUSH TO PRODUCTION REPOSITORY..."
                    sh "docker build -t $DOCKER_USER/prod:latest ."
                    sh "docker push $DOCKER_USER/prod:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                sh "chmod +x deploy.sh"
                sh "./deploy.sh"
            }
        }
    }

    post {
        always {
            cleanWs()
            sh "docker image prune -f"
        }
    }
}
