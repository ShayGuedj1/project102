pipeline {
    agent any

    stages {
        
        stage('Set configurations') {
            steps {
                // grant permissions and run Terraform to provision AWS instance from the install.sg script.
                sh './set-pemissions.sh' 
                sh './convert-ip.sh'
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply Terraform configuration
                    def tfApplyStatus = sh script: 'terraform apply -auto-approve', returnStatus: true
                    if (tfApplyStatus != 0) {
                        error 'Terraform apply failed, destroying resources...'
                        sh 'terraform destroy -auto-approve'
                        currentBuild.result = 'FAILURE'
                    } else {
                        echo 'Terraform apply successful'
                        echo 'success' // Output success message
                    }
                }
            }
        }        

        stage('copy ip') {
            steps {
                // Run a python file to fetch the ip into the inventory file.
                sh 'ls'
                sh 'echo "running python"'
                sh 'sleep 2'
                sh 'python3 set-ip-ansible.py'
                sh 'cat /home/ubuntu/inventory'
                sh 'cat /home/ubuntu/inventory >> hosts' 
                sh 'ls'
                sh 'sleep 2'
                sh 'sudo chmod 700 /home/ubuntu/.ssh'
                sh 'sudo chmod 600 /home/ubuntu/.ssh/authorized_keys'
                


            }
        }
    }

    post {
        always {
            // Delayed cleanup after 5 minutes
            script {
                echo 'Waiting for 5 minutes before cleanup...'
                sleep time: 300, unit: 'SECONDS'
                sh 'terraform destroy -auto-approve'
                sh "echo 'Please wait...'"
                sh 'sleep 5'
                sh "echo 'Project completed!!'"

            }
        }
    }

}
