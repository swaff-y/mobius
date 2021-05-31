commands:
 01_copy_to_temp:
   command: |
      #!/bin/bash
      set -xe
      sudo curl -sL https://rpm.nodesource.com/setup_13.x | sudo bash -
      sudo yum -y install nodejs
      npm install --global yarn
