# 1. Basic
```groovy
pipeline {
    agent { label "mainul" }

    stages {
        stage('Code') {
            steps {
                echo "Cloning the code..."
                git url: "https://github.com/maainul/django-notes-app.git", branch: "master"
                echo "Code cloned successfully!"
            }
        }
        stage('Build') {
            steps {
                echo "Building the Docker image..."
                sh 'docker build -t notes-app:latest .'
                echo "Docker image built successfully!"
            }
        }
        stage('Test') {
            steps {
                echo "Running tests..."
                // Add test commands here if required
                echo "Tests completed!"
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying the application..."
                sh 'docker run -d -p 8000:8000 notes-app:latest || echo "Deployment failed!"'
                echo "Application deployed!"
            }
        }
    }
}
```

# Docker Compose 
```groovy
pipeline {
    agent { label "mainul" }

    stages {
        stage('Code') {
            steps {
                echo "Cloning the code..."
                git url: "https://github.com/maainul/django-notes-app.git", branch: "master"
                echo "Code cloned successfully!"
            }
        }
        stage('Build') {
            steps {
                echo "Building the Docker image..."
                sh 'docker build -t notes-app:latest .'
                echo "Docker image built successfully!"
            }
        }
        stage('Test') {
            steps {
                echo "Running tests..."
                // Add test commands here if required
                echo "Tests completed!"
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
```
## Push to docker hub
```groovy
pipeline {
    agent { label "mainul" }

    stages {
        stage('Code') {
            steps {
                echo "Cloning the code..."
                git url: "https://github.com/maainul/django-notes-app.git", branch: "master"
                echo "Code cloned successfully!"
            }
        }
        stage('Build') {
            steps {
                echo "Building the Docker image..."
                sh 'docker build -t notes-app:latest .'
                echo "Docker image built successfully!"
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
        echo "Pushing ....."
        withCredentials([usernamePassword(
            credentialsId: "docker-hub-cred",
            passwordVariable: "dockerHubPass",
            usernameVariable: 'dockerHubUser')]) {
                sh 'docker login -u ${dockerHubUser} -p ${dockerHubPass}'
                sh 'docker image tag notes-app:latest ${dockerHubUser}/notes-app:latest'
                sh 'docker push ${dockerHubUser}/notes-app:latest'
            }
        echo "Push completed!"
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
```

# With hared Library

```groovy
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
```
