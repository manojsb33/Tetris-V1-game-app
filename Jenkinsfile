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
                sh 'cleanWs'
            }
        }
        stage('Sonarqube Analysis'){
            steps{
                withSonarQubeEnv('sonar-scaner'){
                    sh ''' $SCANNER_HOME/bin/sonar-scaner -Dsonar.projectName=Tetris \
                    -Dsonar.projectkey=Tetris '''
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
    }
}
