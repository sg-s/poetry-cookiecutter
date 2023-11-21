"""tasks to perform after project generation"""


import subprocess

# initialize git repo
subprocess.run(["git", "init"])
subprocess.run(["git", "add", "-A", "."])
subprocess.run(["git", "commit", "-m", "initial commit"])

# install using poetry
subprocess.run(["poetry", "install"])

# install jupyter kernel
subprocess.run(["make", "jupyter"])
