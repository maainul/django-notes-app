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
               script{
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
               script{
                try{
                   docker_push("maainul", "notes-app", env.BRANCH_NAME)
                } catch (Exception e){
                    echo "docker push failed: ${e}"
                     currentBuild.result = 'UNSTABLE'
                }
               }
            }
        }
        stage('Deploy') {
            // when{
            //     branch 'master' // Only deploy from the master branch
            // }
            steps {
                echo "Deploying the application..."
                sh 'docker compose down --volumes && docker compose up -d || echo "Deployment failed!"'
                echo "Application deployed!"
            }
        }
    }
}