pipeline {
    agent any

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
                sh 'cat /home/new_home/inventory >> hosts' 
                sh 'ls'
                sh 'sleep 2'
                sh 'sudo chmod 700 /home/new_home/.ssh'
                sh 'sudo chmod 600 /home/new_home/.ssh/authorized_keys'
                


            }
        }
        
    }
}
