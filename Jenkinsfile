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
    stage('Deploy to Server') {
      steps{
        
        sh "docker container run -d -p 8080:80 --name mywebappserver1 $imagename:$BUILD_NUMBER"
        sh "docker container rm -f mywebappserver"
   
           
      }
    }
    
  }
}

