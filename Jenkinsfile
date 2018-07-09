pipeline {
	agent {
		label 'jenkins3'
	}
	stages {
		stage('Test'){
			steps {
				sh 'export ENV_RAILS=production'
				sh 'rvm use 2.4.2'
				sh 'pwd'
				sh 'pwd'
				sh 'ruby -v'
				sh 'rails -v'
				sh 'brakeman'
			}
		}
	}
}