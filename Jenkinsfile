pipeline {
    agent any

    stages {
        
        stage('Terraform Apply') {
            steps {
                // Run Terraform to provision AWS instance
                sh 'pwd'
                sh 'sudo touch /home/ubuntu/ips.json'
                sh 'sudo touch /home/ubuntu/inventory'
                sh 'sudo chmod 777 /home/ubuntu/ips.json'
                sh 'sudo chmod -R 700 /home/ubuntu/.ssh'
                sh 'sudo chmod 777 set-ip-ansible.py'
                sh 'sudo chmod 777 install.sh'
                sh 'sudo chmod 777 /home/ubuntu/inventory'
                sh './install.sh' 
            }
        }

        stage('copy ip') {
            steps {
                // Run Terraform to provision AWS instance
                sh 'pwd'
                sh 'echo "running pythoin"'
                sh 'sleep 3'
                sh 'python3 set-ip-ansible.py'
                sh 'cat /home/ubuntu/inventory'

            }
        }
        
    }
}