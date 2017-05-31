node {
    stage('Checkout'){
        checkout scm
    }

    stage('Test') {
        sh '''
          rails test
        '''
    }

    stage('Deploy') {
        if (env.BRANCH_NAME == 'master') {
          sh '''
            rails db:migrate
            rails db:reset
            pkill screen
            screen -dmSL jds rails server
          '''
        }
    }
}
