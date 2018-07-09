pipeline {
	agent {
		label 'jenkins3'
	}
	stages {
		stage('Test'){
			steps {
				echo 'pwd'
				echo 'ruby -v'
				echo 'rails -v'
				sh 'brakeman'
			}
		}
	}
}