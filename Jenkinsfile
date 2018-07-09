pipeline {
	agent {
		label 'jenkins3'
	}
	stages {
		stage('Test'){
			steps {
				withRvm('ruby-2.4.2') {
					sh 'export RAILS_ENV=production'
					sh 'pwd'
					sh 'ruby -v'
					sh 'rails -v'
					sh 'brakeman'
				}
			}
		}
	}
}
