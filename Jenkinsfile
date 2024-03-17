pipeline {
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        SCANNER_HOME=tool "sonar-scaner"
    }
    stages{
        stage('Git Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/manojsb33/Tetris-V1-game-app.git'
            }
        }
        stage('Clean Workspace'){
            steps{
                cleanWs()
            }
        }
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Tetris \
                    -Dsonar.projectKey=Tetris '''
                }
            }
        }
        stage('Quality Gate Analysis'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube'
                }
            }
        }
        stage('NPM install'){
            steps{
                sh 'npm install'
            }
        }
        stage('Trivy Scan'){
            steps{
                sh 'trivy fs . > trivyfs.txt'
            }
        }
        stage('OWASP FS Scan'){
            steps{
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'

            }
        }
        stage('Docker build'){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh '''
                        docker build -t tetris ./src
                        docker tag tetris manoj3366/tetris:latest
                        docker push manoj3366/tetris:latest
                        '''
                    }
                }
            }
        }
        stage('Trivy image scan'){
            steps{
                sh 'trivy image manoj3366/tetris:latest > trivyimage.txt'
            }
        }
    }
}
