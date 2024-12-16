pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1' // Set the AWS region as an environment variable
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials')]) {
                    sh '''
                    terraform init
                    '''
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials')]) {
                    sh '''
                    terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials')]) {
                    sh '''
                    terraform plan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials')]) {
                    sh '''
                    terraform apply -auto-approve
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
        success {
            echo 'Terraform applied successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
