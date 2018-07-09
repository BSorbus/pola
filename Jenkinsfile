pipeline {
	agent {
		label 'jenkins3'
	}
	stages {
		stage('Test'){
			steps {
				sh 'pwd'
				sh 'ruby -v'
				sh 'rails -v'
				sh 'brakeman'
			}
		}
	}
}