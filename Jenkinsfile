pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo '🏗️ Building the application...'
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running tests...'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Docker command to run on the remote EC2 server
                    def dockerCmd = 'sudo docker run -p 3080:3080 -d anil2469/applisting:react-2.0'

                    // Use Jenkins SSH credentials
                    sshagent(['ec2-server-key']) {
                        // Run the Docker command on remote EC2 server
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.233.251.217 '${dockerCmd}'"
                    }
                }
            }
        }
    }
}
