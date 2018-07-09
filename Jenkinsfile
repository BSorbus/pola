pipeline {
	agent {
		label 'jenkins3'
	}
	stages {
		stage('Test'){
			steps {
				sh 'export PATH=$PATH:~/.rvm/bin'
				sh 'export RAILS_ENV=production'
				sh 'pwd'
				sh 'ruby -v'
				sh 'rails -v'
				sh 'brakeman'
			}
		}
	}
}
