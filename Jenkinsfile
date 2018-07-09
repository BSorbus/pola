pipeline {
	agent {
		label 'jenkins3'
	}
	stages {
		stage('Test'){
			steps {
				sh 'brakeman'
			}
		}
	}
}