pipeline {
    agent any

    stages {
        
        stage('Terraform Apply') {
            steps {
                // Run Terraform to provision AWS instance
                sh 'pwd'
                sh 'touch ips.josn'
                sh 'sudo chmod 777 ips.json'
                sh 'sudo chmod -R 777 /home/ubuntu/.ssh'
                sh 'chmod 777 install.sh'
                sh 'chmod 777 set-ip-ansible.py'
                sh 'chmod 777 ips.json'
                sh './install.sh' 
            }
        }
        
    }
}