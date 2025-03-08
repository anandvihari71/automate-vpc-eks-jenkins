pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID=credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_REGION            = "ap-south-1"
        
    }

    stages {
        stage('AWS Creds'){
            steps{
                sh '''
                echo "AWS Access Key: $AWS_ACCESS_KEY_ID"
                
                export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                echo "After exporting: $AWS_ACCESS_KEY_ID"   
                '''
            }
        }
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Git Checkout'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/anandvihari71/automate-vpc-eks-jenkins.git']])
                }
            }
        }
        stage('Terraform Init'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform init'
                    }
                }
            }
        }
         stage('Terraform fmt'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
         stage('Terraform validate'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Terraform plan'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform plan'
                    }
                }
            }
        }
        stage('Terraform apply/Destroy'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
    }
}
