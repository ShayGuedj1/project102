pipeline {
    agent any

    environment {
        // Define environment variables.
        ANSIBLE_PLAYBOOK_SERVICES = 'ansible/install-services.yaml'
        ANSIBLE_PLAYBOOK_WEB = 'ansible/install-website.yaml'
        PRIVATE_KEY_PATH = '/home/new_home/.ssh/master'
        IPS_FILE_PATH = '/home/new_home/inventory'

    }

    stages {
        
        stage('Terraform Apply') {
            steps {
                // grant permissions and run Terraform to provision AWS instance from the install.sg script.
                sh 'pwd'
                sh 'ls'
                sh 'sudo touch /home/new_home/ips.json'
                sh 'sudo touch /home/new_home/inventory'
                sh 'sudo touch /home/new_home/hosts'
                sh 'sudo chmod 777 /home/new_home/hosts'
                sh 'sudo chmod 777 /home/new_home/ips.json'
                sh 'sudo chmod 777 /home/new_home/.ssh'
                sh 'sudo chmod 777 set-ip-ansible.py'
                sh 'sudo chmod 777 install.sh'
                sh 'sudo chmod 777 /home/new_home/inventory'
                sh './install.sh' 
                sh 'sudo chown -R jenkins:jenkins /home/new_home'
            }
        }

        stage('copy ip') {
            steps {
                // Run a python file to fetch the ip into the inventory file.
                sh 'ls'
                sh 'echo "running python"'
                sh 'sleep 2'
                sh 'python3 set-ip-ansible.py'
                sh 'cat /home/new_home/inventory'
                sh 'cat /home/new_home/inventory >> /home/new_home/hosts' 
                sh 'ls'
                sh 'sleep 2'
                sh 'sudo chmod 700 /home/new_home/.ssh'
                sh 'sudo chmod 600 /home/new_home/.ssh/authorized_keys'
            }
        }

        stage('Run Ansible Playbook- services') {
            steps {
                sh 'echo $HOME'
                sh 'cd ${HOME}'
                sh "sudo ansible-playbook -i ${IP} ${ANSIBLE_PLAYBOOK_SERVICES} -u ubuntu"
            }
        }
        

        stage('Run Ansible Playbook- web') {
            steps {
                    sh "sudo ansible-playbook -i ${IP} ${ANSIBLE_PLAYBOOK_WEB} -u ubuntu"
            }
        }


    }
    
    /*post {
        always {
            cleanWs() // Clean up the workspace
        }

        success {
            echo 'Pipeline succeeded!'
        }

        failure {
            echo 'Pipeline failed! Destroying Terraform resources...'
            script {
                // Destroy Terraform resources
                sh 'terraform destroy -auto-approve'
            }
        }

        cleanup {
            echo 'Cleanup stage: always executed'
        }
    }  */  
}
