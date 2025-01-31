pipeline {
    agent {
        docker {
            image 'stm32-build-renode:latest'
            args '--privileged -v /dev/bus/usb:/dev/bus/usb'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Amid68/Nucleo-Boards-Programming-with-the-STM32CubeIDE.git'
            }
        }

        /* ---------- FlashLED Project ---------- */

        stage('Build FlashLED') {
            when {
                // Only run if anything changed in the FlashLED subdirectory
                changeset "FlashLED/**"
            }
            steps {
                script {
                    // Go into the FlashLED's Release folder and build
                    dir("FlashLED/Release") {
                        sh "make clean"
                        sh "make all"
                    }
                }
            }
        }

        stage('Test FlashLED') {
            when {
                changeset "FlashLED/**"
            }
            steps {
                script {
                    // Example renode-test call
                    def testResults = sh(
                        script: '''
                            renode-test --robot \
                                -r FlashLED/tests/renode/flash_led_test.resc \
                                --variable bin_path:FlashLED/Release/FlashLED.elf
                        ''',
                        returnStatus: true
                    )
                    if (testResults != 0) {
                        unstable("FlashLED tests failed")
                    }
                }
            }
        }

        stage('Archive FlashLED') {
            when {
                changeset "FlashLED/**"
            }
            steps {
                archiveArtifacts artifacts: 'FlashLED/Release/*.elf, FlashLED/Release/*.map'
            }
        }

        /* ---------- AlternateLEDs Project ---------- */

        stage('Build AlternateLEDs') {
            when {
                // Only run if anything changed in the AlternateLEDs subdirectory
                changeset "AlternateLEDs/**"
            }
            steps {
                script {
                    // Go into the AlternateLEDs's Release folder and build
                    dir("AlternateLEDs/Release") {
                        sh "make clean"
                        sh "make all"
                    }
                }
            }
        }

        stage('Test AlternateLEDs') {
            when {
                changeset "AlternateLEDs/**"
            }
            steps {
                script {
                    // Adjust your Renode test scenario and ELF path
                    // if you have a test for AlternateLEDs
                    def testResults = sh(
                        script: '''
                            renode-test --robot \
                                -r AlternateLEDs/tests/renode/alternate_leds_test.resc \
                                --variable bin_path:AlternateLEDs/Release/AlternateLEDs.elf
                        ''',
                        returnStatus: true
                    )
                    if (testResults != 0) {
                        unstable("AlternateLEDs tests failed")
                    }
                }
            }
        }

        stage('Archive AlternateLEDs') {
            when {
                changeset "AlternateLEDs/**"
            }
            steps {
                archiveArtifacts artifacts: 'AlternateLEDs/Release/*.elf, AlternateLEDs/Release/*.map'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}

