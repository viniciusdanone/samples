#!/bin/bash
fn_install_agent(){
    wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
    dpkg -i -E ./amazon-cloudwatch-agent.deb
}

fn_create_config(){ 
    wget https://raw.githubusercontent.com/viniciusdanone/samples/master/config.json
    mv config.json /opt/aws/amazon-cloudwatch-agent/bin/
}

fn_apply_agent(){
    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a status
}
cd /root

fn_install_agent;
fn_create_config;
fn_apply_agent;