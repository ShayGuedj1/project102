pipeline {
    agent any

    stages {
        
        stage('Terraform Apply') {
            steps {
                // Run Terraform to provision AWS instance
                sh 'pwd'
                sh 'ls'
                sh 'sudo touch /home/ubuntu/ips.json'
                sh 'sudo touch /home/ubuntu/inventory'
                sh 'sudo touch /home/ubuntu/hosts'
                sh 'sudo chmod 777 /home/ubuntu/hosts'
                sh 'sudo chmod 777 /home/ubuntu/ips.json'
                sh 'sudo chmod 777 /home/ubuntu/.ssh'
                sh 'sudo chmod 777 set-ip-ansible.py'
                sh 'sudo chmod 777 install.sh'
                sh 'sudo chmod 777 /home/ubuntu/inventory'
                sh './install.sh' 
            }
        }

        stage('copy ip') {
            steps {
                // Run Terraform to provision AWS instance
                sh 'ls'
                sh 'echo "running python"'
                sh 'sleep 3'
                sh 'python3 set-ip-ansible.py'
                sh 'cat /home/ubuntu/inventory'
                sh 'cat /home/ubuntu/inventory >> hosts' 
                sh 'ls'
                sh 'sleep 5'
                sh 'sudo chmod 700 /home/ubuntu/.ssh'
                sh 'sudo chmod 600 /home/ubuntu/.ssh/authorized_keys'
                sh 'sudo chown -R jenkins:jenkins /home/ubuntu/.ssh'
                sh 'sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa.pub'


            }
        }
        
    }
}
