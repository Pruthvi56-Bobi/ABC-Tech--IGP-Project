pipeline 
{
    agent any
    stages 
    {
        stage('Checkout Code') 
        {
            steps 
            {
              git 'https://github.com/Pruthvi56-B/ABC-Tech--IGP-Project.git'
            }
        }

        stage('Code Compile') 
        {
          steps 
          {
            sh 'mvn compile'
          }
        }

        stage('Unit Test') 
        {
           steps 
          {
            sh 'mvn test'
          }
        }
        
        stage('Code Pachaging') 
        {
          steps 
          {
            sh 'mvn package'
          }
        }
  }
}

