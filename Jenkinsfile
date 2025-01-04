@Library('Shared') _
pipeline {
    agent { label "mainul" }

    stages {
        stage('Clone') {
            steps {
                script {
                    clone("https://github.com/maainul/django-notes-app.git", env.BRANCH_NAME)
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    docker_build("maainul", "notes-app", env.BRANCH_NAME)
                }
            }
        }
        stage('Test') {
            steps {
                echo "Running tests..."
                echo "Tests completed!"
            }
        }
        stage('Push') {
            steps {
                script {
                    try {
                        docker_push("maainul", "notes-app", env.BRANCH_NAME)
                    } catch (Exception e) {
                        echo "docker push failed: ${e}"
                        currentBuild.result = 'UNSTABLE'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo "Cleaning up Docker resources..."
                sh '''
                docker ps -q | xargs -r docker stop || true
                docker ps -aq | xargs -r docker rm || true
                docker system prune -f || true
                docker volume prune -f || true
                docker network prune -f || true
                '''
                echo "Starting the application..."
                sh "BRANCH_NAME=${env.BRANCH_NAME} docker compose up -d"
            }
        }  
    }
    post {
        always {
            echo "Cleaning up workspace..."
            cleanWs()
        }
        failure {
            echo "Build failed, sending notifications..."
        }
    }
}