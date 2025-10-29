pipeline {
    agent any

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
                    buildImage(env.IMAGE_NAME)   // buildImage() from shared library
                    dockerLogin()                // login to Docker registry
                    dockerPush(env.IMAGE_NAME)  // push image to Docker registry
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    echo 'Deploying Docker image to EC2...'
                    def dockerCmd = "docker run -p 3080:3080 -d ${IMAGE_NAME}"
                    sshagent(['ec2-server-key-1']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.242.92 '${dockerCmd}'"
                    }
                }
            }
        }

    } 
}
