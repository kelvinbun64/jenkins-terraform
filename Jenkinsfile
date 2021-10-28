pipeline {
  agent any
  tools {
      terraform 'Terraform v1.0.10'
  }

  stages {
    stage('Git Checkout') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/kelvinbun64/jenkins-terraform.git']]])
      }
    }

    stage('Terraform Init') {
      steps {
        script{
              sh 'terraform init'
        }
      }
    }
    
    stage('Terraform Plan') {
      steps {
          script{
              sh 'terraform plan'
          }
      }
    }
    
    stage('Terraform apply') {
      steps {
        script{
              sh 'terraform apply --auto-approve'
        }
      }
    }
  }
}
