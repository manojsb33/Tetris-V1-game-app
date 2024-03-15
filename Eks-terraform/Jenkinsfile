pipeline{
    agent any
    stages{
        stage('Git-Checkot'){
            steps{
                git branch: 'main', url: 'https://github.com/manojsb33/Tetris-V1-game-app.git'

            }
        }
        stage('Launching EKS through Terraform'){
            steps{
                dir('Eks-terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Validate'){
            steps{
                dir('Eks-terraform') {
                    sh 'terraform validate'
                }
            }
        }
        stage('Terraform Plan'){
            steps{
                dir('Eks-terraform') {
                    sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply/Destroy'){
            steps{
                dir('Eks-terraform') {
                    sh 'terraform ${action} --auto-approve'
                }
            }
        }
    }
}
