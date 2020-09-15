#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# màu sắc
blue='\033[0;34m'
yellow='\033[0;33m'
green='\033[0;32m'
red='\033[0;31m'
plain='\033[0m'

#Kiểm tra xem nó có phải Root không
[ $(id -u) != "0" ] && { echo -e "${red}[Loi]${plain} Ban phai cai dat voi tu cach root user"; exit 1; }

echo ""
echo "Cai dat phien ban Cr@ck pro"
echo ""
echo -e "${red}[CanhBao]"
echo -e "${plain}Chuong trinh nay ca nhan hoa, chua 5.9"
echo "Neu co vi pham lien he tac gia"
echo "Sau khi cat dat dung thu"
echo ""
echo -e "${yellow}[MoTa]"
echo -e "${plain}This script must be completely clean Install on the system CentOS/Debian/Ubuntu "
echo "If a higher version has been installed, please uninstall the higher version before installing"
echo "If you have installed other types of panels, or operating environment such as LNMP, reinstall the clean system and then install"
echo "I am not responsible for any adverse consequences of using this script"
echo ""
echo -e "${blue}[StandBy]"
echo -e "${plain}zhihu: https://www.zhihu.com/people/deepdarkfantastic"
echo "email: net.core@outlook.com"
echo ""

#Confirm installation
while [ "$go" != 'y' ] && [ "$go" != 'n' ]
do
    read -p "Are you sure you want to install?(y/n): " go;
done
if [ "$go" = 'n' ];then
    exit;
fi

#Check system information
if [ -f /etc/redhat-release ] && [[ `grep -i 'centos' /etc/redhat-release` ]]; then
    OS='CentOS'
elif [ ! -z "`cat /etc/issue | grep bian`" ];then
    OS='Debian'
elif [ ! -z "`cat /etc/issue | grep Ubuntu`" ];then
    OS='Ubuntu'
else
    echo -e "${red}[error]${plain} Your operating system is not supported, please select Ubuntu/Debian/CentOS Install on the operating system!"
    exit 1
fi

#Disable SELinux
if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    setenforce 0
fi

#Output the major version number of the centos system
System_CentOS=`rpm -q centos-release|cut -d- -f1`
CentOS_Version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`

#CentOS 6 dedicated python
install_python_for_CentOS6() {
    py_for_centos="https://raw.githubusercontent.com/leitbogioro/SSR.Go/master/python_for_centos6.sh"
    py_intall="python_for_centos6.sh"
    yum install wget -y
    wget ${py_for_centos}
    if ! wget ${py_for_centos}; then
        echo -e "[${red}error${plain}] ${py_file} The download failed, please check your network!"
        exit 1
    fi
    bash ${py_intall}
    rm -rf /root/${py_intall}
}

#CentOS 7 Dedicated pip source
install_python_for_CentOS7() {
    pip_file="get-pip.py"
    pip_url="https://bootstrap.pypa.io/get-pip.py"
    yum install python -y
    curl ${pip_url} -o ${pip_file}
    if ! curl ${pip_url} -o ${pip_file}; then
        echo -e "[${red}error${plain}] ${pip_file} The download failed, please check your network!"
        exit 1
    fi
    python ${pip_file}
    rm -rf /root/${pip_file}
}

install_btPanel_for_CentOS() {
    yum install -y wget && wget -O install.sh https://raw.githubusercontent.com/vanbac91/Crack_BT_Panel2020/master/install.sh && bash install.sh
    wget -O update.sh https://raw.githubusercontent.com/vanbac91/Crack_BT_Panel2020/master/update_pro/update_pro.sh && bash update.sh pro
}

install_btPanel_for_APT() {
    wget -O install.sh https://raw.githubusercontent.com/vanbac91/Crack_BT_Panel2020/master/install-ubuntu.sh && bash install.sh
    wget -O update.sh https://raw.githubusercontent.com/vanbac91/Crack_BT_Panel2020/master/update_pro/update_pro.sh && bash update.sh pro
}

#Cracking steps
crack_bt_panel() {
    export Crack_file=/www/server/panel/class/common.py
    echo -e "${yellow}[note] ${plain}Cracking execution..."
    /etc/init.d/bt stop
    sed -i $'164s/panelAuth.panelAuth().get_order_status(None)/{\'status\': \True, \'msg\': {\'endtime\': 32503651199}}/g' ${Crack_file}
    touch /www/server/panel/data/userInfo.json
    /etc/init.d/bt restart
}

#Restart the pagoda panel regularly
execute_bt_panel() {
    if ! grep '/etc/init.d/bt restart' /etc/crontab; then
        systemctl enable cron.service
        systemctl start cron.service
        echo "0  0    * * 0   root    /etc/init.d/bt restart" >> /etc/crontab
        /etc/init.d/cron restart
    fi
}

#Turn on ssl
enable_ssl(){
    if [ ! -f /www/server/panel/data/ssl.pl ]; then
        echo "Ture" > /www/server/panel/data/ssl.pl
        /usr/bin/python /usr/local/bin/pip install pyOpenSSL==16.2
        /etc/init.d/bt restart
    fi
}

# Clean up after installation
clean_up() {
    rm -rf crack_bt_panel_pro.sh
    rm -rf update.sh
    if [[ ${OS} == 'Ubuntu' ]] || [[ ${OS} == 'Debian' ]]; then
        apt-get autoremove -y
    fi
    # Delete all kinds of residue
    rm -rf /www/server/panel/plugin/btyw /root/install_cjson.sh /root/.pip /root/.pydistutils.cfg
}

# Pre-installed components
components(){
    cd /root
    wget -O lib.sh https://raw.githubusercontent.com/vanbac91/Crack_BT_Panel2020/master/lib.sh
    mv lib.sh /www/server/panel/install
    wget -O nginx.sh https://raw.githubusercontent.com/vanbac91/Crack_BT_Panel2020/master/nginx.sh
    mv nginx.sh /www/server/panel/install
    if [ -f /www/server/panel/install/install_soft.sh ]; then
        rm -rf install_soft.sh
        wget -O install_soft.sh https://raw.githubusercontent.com/vanbac91/Crack_BT_Panel2020/master/install_soft.sh
        mv install_soft.sh /www/server/panel/install
    fi
}

# Plugin configuration
vip_plugin(){
    # Install all paid premium plugins by default
    cd /www/server/panel/plugin
    if [ ! -d "/masterslave" ]; then
        wget -O vip_plugin.zip https://raw.githubusercontent.com/vanbac91/Crack_BT_Panel2020/master/update_pro/vip_plugin.zip
        unzip vip_plugin.zip
        rm -f vip_plugin.zip
    fi
    cd /root
}

#Official installation
if [[ ${OS} == 'CentOS' ]] && [[ ${CentOS_Version} -eq "7" ]]; then
    yum install epel-release wget curl nss fail2ban unzip lrzsz vim* -y
    yum update -y
    yum clean all
    install_btPanel_for_CentOS
    install_python_for_CentOS7
    crack_bt_panel
    #enable_ssl
    #vip_plugin
elif [[ ${OS} == 'CentOS' ]] && [[ ${CentOS_Version} -eq "6" ]]; then
    yum install epel-release wget curl nss fail2ban unzip lrzsz vim* -y
    yum update -y
    yum clean all
    install_btPanel_for_CentOS
    install_python_for_CentOS6
    crack_bt_panel
    #enable_ssl
    #vip_plugin
elif [[ ${OS} == 'Ubuntu' ]] || [[ ${OS} == 'Debian' ]]; then
    apt-get update
    apt-get install ca-certificates -y
    apt-get install sudo apt-transport-https vim vim-gnome libnet-ifconfig-wrapper-perl socat vim vim-gnome vim-gtk libnet-ifconfig-wrapper-perl socat lrzsz fail2ban wget curl unrar unzip cron dnsutils net-tools git git-svn make cmake gdb tig -y
    install_btPanel_for_APT
    crack_bt_panel
    components
    #enable_ssl
    #vip_plugin
    execute_bt_panel    
fi

clean_up

echo -e "${green}[carry out] ${plain}The cracked version of the pagoda panel has been installed successfully！"
echo "Log in to the panel and use it according to the background entrance, account number, and password provided by the script!"
