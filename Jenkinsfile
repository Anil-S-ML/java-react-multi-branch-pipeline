pipeline {
    agent any

    stages {

        stage('Build Application') {
            steps {
                echo '🏗️ Building application JAR...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image and Push') {
            steps {
                script {
                    echo '🐳 Building and pushing Docker image...'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', usernameVariable: 'US', passwordVariable: 'PASS')]) {
                        sh """
                            docker build -t anil2469/applisting:java-react-3.0 .
                            echo \$PASS | docker login -u \$US --password-stdin
                            docker push anil2469/applisting:java-react-3.0
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
                        docker pull anil2469/applisting:java-react-3.0 &&
                        docker run -d -p 3080:3080 --name app anil2469/applisting:java-react-3.0
                    """
                    sshagent(['ec2-server-key-1']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.242.92 '${dockerCmd}'"
                    }
                }
            }
        }
    }
}
