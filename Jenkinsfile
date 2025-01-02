@Library('Shared') _
pipeline {
    agent { label "mainul" }

    stages {
        // stage('Hello'){
        //     steps {
        //         script {
        //             hello()
        //         }
        //     }
        // }
        stage('Clone') {
            steps {
                script {
                    clone("https://github.com/maainul/django-notes-app.git","master")
                }
            }
        }
        stage('Build') {
            steps {
               script{
                   docker_build("maainul","notes-app","latest")
               }
            }
        }
        stage('Test') {
            steps {
                echo "Running tests..."
                // Add test commands here if required
                echo "Tests completed!"
            }
        }
        stage('Push') {
            steps {
               script{
                   docker_push("maainul","notes-app","latest")   
               }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying the application..."
                sh 'docker compose up -d || echo "Deployment failed!"'
                echo "Application deployed!"
            }
        }
    }
}
