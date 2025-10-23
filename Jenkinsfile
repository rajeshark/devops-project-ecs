pipeline {
    agent any

    environment {
        AWS_REGION      = 'ap-south-1'
        PROJECT_NAME    = 'devops-project'
        AWS_CREDENTIALS = credentials('aws-creds-id')
        ECR_ACCOUNT     = '775826428475'
        ECR_REGION      = "${env.AWS_REGION}"
    }

    stages {

        stage('Build & Push Docker Images') {
            steps {
                script {
                    def services = ['auth','product','cart','order','payment','email']
                    for (service in services) {
                        sh """
                        aws ecr describe-repositories --repository-names ${service} --region ${ECR_REGION} || \
                        aws ecr create-repository --repository-name ${service} --region ${ECR_REGION}

                        cd ${service}
                        docker build -t ${ECR_ACCOUNT}.dkr.ecr.${ECR_REGION}.amazonaws.com/${service}:latest .
                        aws ecr get-login-password --region ${ECR_REGION} | docker login --username AWS --password-stdin ${ECR_ACCOUNT}.dkr.ecr.${ECR_REGION}.amazonaws.com
                        docker push ${ECR_ACCOUNT}.dkr.ecr.${ECR_REGION}.amazonaws.com/${service}:latest
                        cd ..
                        """
                    }
                }
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds-id']]) {
                    dir('terraform') {
                        sh """
                        terraform init
                        terraform apply -auto-approve
                        """
                    }
                }
            }
        }

        stage('Build & Deploy Frontend to S3') {
    steps {
        script {
            // Get ALB DNS dynamically from Terraform output
            env.ALB_DNS = sh(script: "terraform output -raw alb_dns_name", returnStdout: true).trim()
            echo "ALB DNS: ${env.ALB_DNS}"

            sh """
            cd frontend
            # Replace the REACT_APP_API_URL in .env with the ALB DNS
            sed -i 's|REACT_APP_API_URL=.*|REACT_APP_API_URL=http://${env.ALB_DNS}|' .env

            rm -rf node_modules package-lock.json
            npm install

            chmod +x node_modules/.bin/*

            export CI=false
            npm run build

            aws s3 sync build/ s3://devops-project-frontend-rajesh --region ${AWS_REGION}
            """
        }
    }
}


    post {
        success { 
            echo 'Deployment to ECS + ALB + frontend S3 complete!' 
        }
        failure { 
            echo 'Deployment failed.' 
        }
    }
}
