#!/usr/bin/env bash

# Magento install variables
dbhost="localhost"
dbname="m240"
dbuser="root"
dbpass="admin@123"
base_url="http://m240.com/"
admin_firstname="rock"
admin_lastname="asif"
admin_email="rock@rocktechnolabs.com"
admin_username="rock"
admin_pass="rock@123"
language="en_US"
backend_frontname="admin"
mage_mode="default"

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "options:"
            echo "-h,       --help                                Show brief help"
            echo "-r,       --run-instalation=DIR                 Run Instalation"
            echo "-rs,      --run-instalation-sampledata=DIR      Run instalation with sampledata"
            echo "-rce,     --run-extension-by-composer           Run composer to install extension"
            echo "-email,   --run-email                           Run for check email"
            echo "-ssl,     --run-ssl                             Run for check ssl"
            exit 0
            ;;
        -rs|--run-instalation-sampledata)
            shift
                echo Start composer instalation project;
                composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition m240;
                echo Start SampleData deploy;
                php -d memory_limit=-1 m240/bin/magento sampledata:deploy;
                echo Start Magento install;
                php -d memory_limit=-1 m240/bin/magento setup:install --base-url=$base_url --db-host=$dbhost --db-name=$dbname --db-user=$dbuser --db-password=$dbpass --admin-firstname=$admin_firstname --admin-lastname=$admin_lastname --admin-email=$admin_email --admin-user=$admin_username --admin-password=$admin_pass --language=$language --backend-frontname=$backend_frontname --use-sample-data --magento-init-params="MAGE_MODE=$mage_mode";
                echo Start compilation;
                php -d memory_limit=-1 m240/bin/magento s:up
                php -d memory_limit=-1 m240/bin/magento s:d:c
                php -d memory_limit=-1 m240/bin/magento s:static-c:d -f
                php -d memory_limit=-1 m240/bin/magento indexer:reindex
                php -d memory_limit=-1 m240/bin/magento c:f
                chmod -R 777 m240/var/* m240/generated/* /m240/pub/static/*
            shift
            ;;
        -rce|--run-extension-by-composer)
            shift
                chmod -R 777 m240/
                echo Start composer instalation extension;
                cd m240 && composer require mageplaza/magento-2-blog-extension
                rm -rf generated/* var/* pub/static/adminhtml/* pub/static/frontend/*
                php -d memory_limit=-1 bin/magento s:up
                php -d memory_limit=-1 bin/magento s:d:c
                php -d memory_limit=-1 bin/magento s:static-c:d -f
                #php -d memory_limit=-1 bin/magento indexer:reindex
                php -d memory_limit=-1 bin/magento c:f
                chmod -R 777 var/* generated/* pub/static/*
            shift
            ;;
        -re|--run-extension)
            shift
                chmod -R 777 m240/
                echo Start compilation;
                rm -rf m240/generated/* m240/var/* m240/pub/static/adminhtml/* m240/pub/static/frontend/*
                php -d memory_limit=-1 m240/bin/magento s:up
                php -d memory_limit=-1 m240/bin/magento s:d:c
                php -d memory_limit=-1 m240/bin/magento s:static-c:d -f
                #php -d memory_limit=-1 m240/bin/magento indexer:reindex
                php -d memory_limit=-1 m240/bin/magento c:f
                chmod -R 777 m240/var/* m240/generated/* m240/pub/static/*
            shift
            ;;
        -email|--run-email)
            shift
                echo Check Email;
                echo "hello world for test email" | mail -s "a subject" asif@rocktechnolabs.com;
            shift
            ;;
        -ssl|--run-ssl)
            shift
                echo Check Email;
                echo | openssl s_client -servername unix.stackexchange.com -connect unix.stackexchange.com:443 2>/dev/null | openssl x509 -noout -issuer -subject -dates
            shift
            ;;
        *)
            echo "The initialization process was not performed!"
            break
            ;;
    esac
done