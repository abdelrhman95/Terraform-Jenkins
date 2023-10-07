pipeline {
    agent any
    parameters {
        choice(name: 'server', choices: ["Dev", "Prod"], description: 'Select environment')
    }
    environment {
        AWS_ACCESS_KEY_ID=credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY=credentials('AWS_SECRET_KEY')
    }
    stages {
        stage("Clone Git Repository") {
            steps {
                git(
                    url: "https://github.com/abdelrhman95/Terraform-Jenkins",
                    branch: "master",
                    poll: true
                )
            }
        }
        stage('Terraform Init') {
            steps {
                dir ("day2/"){
                sh 'terraform init'}
                
            }
        }
        stage('Terraform Plan') {
            steps {
                dir ("day2/"){
                script {
                    def env = params.server
                    def tfVarsFile

                    if (env == 'Dev') {
                        tfVarsFile = 'dev.tfvars'
                        sh 'terraform workspace new Dev || true' 
                        sh 'terraform workspace select Dev '
                    } else if (env == 'Prod') {
                        tfVarsFile = 'prod.tfvars'
                        sh 'terraform workspace new prod || true' 
                        sh 'terraform workspace select prod '
                    }

                    sh "terraform plan --var-file=${tfVarsFile}"
                    
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir ("day2/"){
                script {
                    def env = params.server
                    def tfVarsFile

                    if (env == 'Dev') {
                        tfVarsFile = 'dev.tfvars'
                        sh 'terraform workspace new Dev || true' 
                        sh 'terraform workspace select Dev '
                    } else if (env == 'Prod') {
                        tfVarsFile = 'prod.tfvars'
                        sh 'terraform workspace new prod || true' 
                        sh 'terraform workspace select prod '
                    }
                
                    
                    
                    sh "terraform apply --var-file=${tfVarsFile} -auto-approve"
                
                    }
                }    
            }
        }
    }
}

