pipeline{
    agent { 
        label 'agent1'
    }
    stages{
        stage('Checkout TO DEVELOP'){
            when{
                branch 'develop'
            }
            steps{
                git url: 'https://github.com/eslamelmishtawy/iti-g106.git', branch: 'develop',
                credentialsId: 'git-credentials'
            }
            
        }
        stage('Checkout TO MASTER'){
            when{
                branch 'master'
            }
            steps{
                git url: 'https://github.com/eslamelmishtawy/iti-g106.git', branch: 'master',
                credentialsId: 'git-credentials'
            }
            
        }
        stage('Build Artifact With Maven'){
            steps{
                sh '''
                mvn -f pom.xml clean package
                '''
            }
            post {
                success {
                    junit(
                     skipPublishingChecks: true,
                    testResults: 'target/surefire-reports/**/*.xml'
                    ) 
                }
            }
        }

        stage('Build Docker Image'){
            steps{
               sh '''
                docker build -t bmi:$BUILD_NUMBER .
                git push origin $BUILD_NUMBER
               '''
            }
        }
        }
    }
