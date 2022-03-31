pipeline {
    environment {
        registry = "nishanthkp/python-flask-app"
        registryCredential = "nishanthdockerhubcreds"
        dockerImage = ''
    }
    agent any
    stages {
        stage('Cloning the Code') {
            steps {
                echo 'Cloning the Code from Git'
                git branch:'main', url: 'https://github.com/nishanthkumarpathi/python-flask-app.git'
            }
        }
        stage('SCA using Bandit') {
            steps {
                echo 'Scanning the Source Code using Bandit'
                sh 'docker run --user $(id -u):$(id -g) -v $(pwd):/src --rm secfigo/bandit bandit -r /src -f json -o /src/bandit-output.json | exit 0'
            }
        }       
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Delete Docker Image from Local Computer') {
            steps {
                echo 'Deleting the Docker Image'
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploy the App using Ansible'
                sh "kubectl apply -f deployment.yml"
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'bandit-output.json',onlyIfSuccessful: true
        }
    }
}
