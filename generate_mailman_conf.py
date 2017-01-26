#!/usr/bin/env python3

import os

import configparser

CONF_FILE='/etc/mailman.cfg'

config = configparser.ConfigParser()
config.read(CONF_FILE)

config['paths.here']={'var_dir': '{}'.format(os.getenv('MAILMAN_HOME'))}

config['mta'] = {}
config['mta']['incoming']='mailman.mta.postfix.LMTP'
config['mta']['outgoing']='mailman.mta.deliver.deliver'
config['mta']['lmtp_host']=os.getenv('HOSTNAME')
config['mta']['lmtp_port']='8024'
config['mta']['smtp_host']=os.getenv('MAILMAN_SMTP_HOST')
config['mta']['smtp_port']=os.getenv('MAILMAN_SMTP_PORT', '25')

config['webservice'] = {}
config['webservice']['hostname']=os.getenv('HOSTNAME')
config['webservice']['port']='8001'
config['webservice']['admin_user']=os.getenv('MAILMAN_REST_API_USER', 'restdmin' )
config['webservice']['admin_pass']=os.getenv('MAILMAN_REST_API_PASS', 'restpass')

config['mailman'] = {}
config['mailman']['site_owner']=os.getenv('MAILMAN_SITE_OWNER', 'admin@{}'.format(os.getenv('HOSTNAME')))

config['archiver.hyperkitty'] = {}
config['archiver.hyperkitty']['class']='mailman_hyperkitty.Archiver'
config['archiver.hyperkitty']['enable']=os.getenv('MAILMAN_HYPER_KITTY_ENABLE', 'False')
config['archiver.hyperkitty']['configuration']='/etc/hyperkitty.cfg'

with open(CONF_FILE, 'w') as configfile:
    config.write(configfile)
