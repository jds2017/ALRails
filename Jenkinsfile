node {
    stage('Checkout'){
        checkout scm
    }

    stage('Install Dependencies') {
      sh '''
        source /usr/local/rvm/scripts/rvm
        bundle install
      '''
    }

    stage('Test') {
        sh '''
          source /usr/local/rvm/scripts/rvm
          rails test
        '''
    }

    stage('Deploy') {
        if (env.BRANCH_NAME == 'master') {
          sh '''
            source /usr/local/rvm/scripts/rvm
            rails db:migrate
            rails db:reset
            pkill screen
            screen -dmSL jds rails server
          '''
        }
    }
}
