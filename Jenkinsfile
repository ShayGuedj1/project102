pipeline {
    agent any
    

    stages {
        
        stage('Checkout') {
            steps {
                // Checkout code from GitHub
                git branch: 'main', credentialsId: 'git-creds', url: 'https://github.com/ShayGuedj1/project102.git'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                // Run Terraform to provision AWS instance
                sh 'terraform init'
                sh 'terraform apply --auto-approve'
            }
        }
        
    
    }
}
