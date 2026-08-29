// Agent for the code

node('linux-agent'){

    // variable declartion for the github url and the brnach
    def GIT_HUB_URL= "https://github.com/vyjith/jenkins-docker-ansible-building-server-using-terraform.git"
    def GIT_HUB_BRANCH= "main"
    def TF_PLAN_FILE= "tfplan-${BUILD_NUMBER}.binary"
    def ZIP_FILE_NAME= "terraform-build-${BUILD_NUMBER}.zip"

    try {

    // git checkout the code 

    stage('Checkout') {
        checkout([$class: 'GitSCM', 
        branches: [[ name: "*/${GIT_HUB_BRANCH}"]], 
        userRemoteConfigs: [[ url: GIT_HUB_URL ]]
        ])
    }

    stage('Terraform validate & result') {
        withCredentials([
            string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws-secret', variable: 'AWS_SECRET_ACCESS_KEY')
        ])
         {
            

        sh '''
           terraform init -input=false
           terraform validate
           terraform plan -var-file=terraform.tfvars -out=''' + TF_PLAN_FILE + ''' -input=false
        '''
      }
    }

    stage('Approval Gate'){
        input message: 'Do you want to apply this terraform changes', ok: 'Apply'

    }


    } catch (Exception  e) {
        currentBuild.result = "FAILURE"
        echo "Pipeline failed due to : ${e.message}"
        throw e
    } finally {
        stage('Clean work space'){
        cleanWs()
    }

    }
}
