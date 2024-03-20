pipeline{
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment{
        SCANNER_HOME=tool 'sonar-scanner'
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
        stage('Sonarqube Analysis'){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=TetrisVersion1.0 \
                    -Dsonar.projectKey=TetrisVersion1.0 '''
                }
            }
        }
        stage('QG'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube'

                }
            }
        } 
        stage('NPM'){
            steps{
                sh 'npm install'
            }
        } 
        stage('Trivy Scan'){
            steps{
                sh 'trivy fs . > trivyfs.txt'
            }
        }
        stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('Docker Build'){
            steps{
                sh 'docker build -t tetris-v1 .'
            }
        }
        stage('Docker Push'){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh 'docker tag tetris-v1 manoj3366/tetris-v1:latest'
                        sh 'docker push manoj3366/tetris-v1:latest'
                    }
                }
            }
        }
        stage('Trivy Image Scan'){
            steps{
                sh 'trivy image manoj3366/tetris-v1:latest > trivyimage.txt'
            }
        }    
    }
}
