pipeline {
  environment {
 
    imagename = "mak1993/reactjs"
    registryCredential = 'mak1993'
    dockerImage = ''
  }
  
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/mayankkh1/dockerreactjs.git', branch: 'master'])
 
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build imagename
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
            
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$BUILD_NUMBER"
      
 
      }
    }
  }
}

