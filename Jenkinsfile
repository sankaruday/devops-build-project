pipeline {
    agent any
    
    environment {
        DOCKER_USER = 'uday2097'
        DOCKER_HUB_CREDS = credentials('dockerhub_creds')
    }

    stages {
        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKER_HUB_CREDS_PSW | docker login -u $DOCKER_HUB_CREDS_USR --password-stdin'
            }
        }

        stage('Build & Push') {
            steps {
                script {
                    // This line ensures we catch 'main', 'master', or 'origin/main'
                    def branch = env.GIT_BRANCH.replace('origin/', '')
                    echo "Current detected branch is: ${branch}"

                    if (branch == 'main' || branch == 'master') {
                        echo "Processing Production Branch... Pushing to uday2097/prod"
                        sh "docker build -t $DOCKER_USER/prod:latest ."
                        sh "docker push $DOCKER_USER/prod:latest"
                    } 
                    else if (branch == 'dev') {
                        echo "Processing Dev Branch... Pushing to uday2097/dev"
                        sh "docker build -t $DOCKER_USER/dev:latest ."
                        sh "docker push $DOCKER_USER/dev:latest"
                    }
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
            // This is vital for your t3.small to keep space free
            cleanWs()
            sh "docker image prune -f"
        }
    }
}
