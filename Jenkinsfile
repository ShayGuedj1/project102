pipeline {
    agent any

    stages {
        
        stage('Terraform Apply') {
            steps {
                // Run Terraform to provision AWS instance
                
                sh 'sudo cp /home/ubuntu/projects.pem .'
                sh 'chmod 777 install.sh'
                sh 'chmod 777 set-ip-ansible.py'
                sh './install.sh' 
            }
        }
        
    }
}