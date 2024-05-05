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
                sh 'sudo chmod -R 777 /home/ubuntu/.ssh'
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
                sh 'ls'
                sh 'sleep 600'
                sh 'echo "running python"'
                sh 'sleep 3'
                sh 'python3 set-ip-ansible.py'
                sh 'cat /home/ubuntu/inventory'
                sh 'sudo chmod 600 /home/ubuntu/.ssh'

            }
        }

        stage('run ansible') {
            steps {
                // Run Terraform to provision AWS instance
                sh 'cd ansible/'
                sh 'ansible-playbook -i /home/ubuntu/inventory /ansible/install-services.yaml'

            }
        }
        
    }
}
