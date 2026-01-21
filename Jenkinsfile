pipeline {
  agent any
  tools {
    jdk 'Java17'
    maven 'Maven'
  }
  stages {
    stage('Checkout Code') {
      steps {
        echo 'Pulling from Github'
        git branch: 'main', credentialsId: 'Git-cred', url: 'https://github.com/Tpawar25/k8Testjenkin.git'
      }
    }
    stage('Test Code') {
      steps {
        echo 'JUNIT Test case execution started'
        bat 'mvn clean test'

      }
      post {
        always {
		  junit '**/target/surefire-reports/*.xml'
          echo 'Test Run is SUCCESSFUL!'
        }

      }
    }
    stage('Build Project') {
      steps {
        echo 'Building Java project'
        bat 'mvn clean package -DskipTests'
      }
    }
    stage('Build the Docker Image') {
      steps {
        echo 'Building Docker Image'
        bat 'docker build -t myjavaproj:1.0 .'
      }
    }
    stage('Push Docker Image to Docker Hub') {
          steps {
            echo 'Pushing Docker Image'
           withCredentials([string(credentialsId: 'docker-cred1', variable: 'DOCKER_PASS')]) {
            bat '''

           echo %DOCKER_PASS% | docker login -u Tpawar02 --password-stdin
           docker tag myjavaproj:01 Tpawar02/myindiaproj:1.0
           docker push Tpawar02/myindiaproj:1.0

            '''
           }

          }
        }


//     stage('Run Docker Container') {
//       steps {
//         echo 'Running Java Application'
//         bat '''
//         docker rm -f myjavaproj-container || exit 0
//         docker run --name myjavaproj-container myjavaproj:1.0
//
//         '''
//       }
//     }
  }
  post {
    success {
      echo 'BUild and Run is SUCCESSFUL!'
    }
    failure {
      echo 'OOPS!!! Failure.'
    }
  }
}