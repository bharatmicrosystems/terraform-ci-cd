yum install epel-release -y
yum install java-1.8.0-openjdk.x86_64 -y
yum install wget -y
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y
./usr/local/bin/install-plugins.sh ssh-slaves
#
# # install Notifications and Publishing plugins
./usr/local/bin/install-plugins.sh email-ext
./usr/local/bin/install-plugins.sh mailer
./usr/local/bin/install-plugins.sh slack
#
./usr/local/bin/install-plugins.sh htmlpublisher
#
# # UI
./usr/local/bin/install-plugins.sh greenballs
./usr/local/bin/install-plugins.sh simple-theme-plugin
#
# # Scaling
./usr/local/bin/install-plugins.sh kubernetes
systemctl enable jenkins
systemctl start jenkins
firewall-cmd --zone=public --permanent --add-port=8080/tcp
firewall-cmd --reload
