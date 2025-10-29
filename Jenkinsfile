pipeline {
    agent any

    tools {
        maven 'maven 3.9'  
    }

    environment {
        IMAGE_NAME = 'anil2469/applisting:java-react-3.0'
    }

    stages {

        stage('Build Application') {
            steps {
                echo 'Building application JAR...'
                buildJar()  
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building the Docker image...'
                    buildImage(env.IMAGE_NAME)   
                    dockerLogin()                
                    dockerPush(env.IMAGE_NAME)  
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    echo 'Deploying Docker image to EC2...'
                    def dockerCmd = "docker run -p 3080:3080 -d ${IMAGE_NAME}"
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.242.92 '${dockerCmd}'"
                    }
                }
            }
        }

    } 
}
