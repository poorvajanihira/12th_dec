pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        TF_VAR_aws_access_key = credentials('aws-credentials').AWS_ACCESS_KEY_ID
        TF_VAR_aws_secret_key = credentials('aws-credentials').AWS_SECRET_ACCESS_KEY
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                terraform init
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                terraform plan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                terraform apply -auto-approve
                '''
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