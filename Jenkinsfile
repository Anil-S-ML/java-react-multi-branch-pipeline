pipeline {
    agent any

    tools {
        maven 'maven-3.9'  // Make sure this matches the name in Jenkins > Global Tool Configuration
    }

    environment {
        IMAGE_NAME = 'anil2469/applisting:java-react-3.0'
    }

    stages {

        stage('Build Application') {
            steps {
                echo '🏗️ Building application JAR...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    echo '🐳 Building and pushing Docker image...'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', usernameVariable: 'US', passwordVariable: 'PASS')]) {
                        sh """
                            docker build -t ${IMAGE_NAME} .
                            echo \$PASS | docker login -u \$US --password-stdin
                            docker push ${IMAGE_NAME}
                        """
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    echo '🚀 Deploying Docker image to EC2...'
                    def dockerCmd = """
                        docker rm -f app || true &&
                        docker pull ${IMAGE_NAME} &&
                        docker run -d -p 3080:3080 --name app ${IMAGE_NAME}
                    """
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.242.92 '${dockerCmd}'"
                    }
                }
            }
        }
    }
}
