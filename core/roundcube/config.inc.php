<?php

/*
 +-----------------------------------------------------------------------+
 | Local configuration for the Roundcube Webmail installation.           |
 |                                                                       |
 | This is a sample configuration file only containing the minimum       |
 | setup required for a functional installation. Copy more options       |
 | from defaults.inc.php to this file to override the defaults.          |
 |                                                                       |
 | This file is part of the Roundcube Webmail client                     |
 | Copyright (C) 2005-2013, The Roundcube Dev Team                       |
 |                                                                       |
 | Licensed under the GNU General Public License version 3 or            |
 | any later version with exceptions for skins & plugins.                |
 | See the README file for a full license statement.                     |
 +-----------------------------------------------------------------------+
*/

$config = array();

// Database connection string (DSN) for read+write operations
// Format (compatible with PEAR MDB2): db_provider://user:password@host/database
// Currently supported db_providers: mysql, pgsql, sqlite, mssql or sqlsrv
// For examples see http://pear.php.net/manual/en/package.database.mdb2.intro-dsn.php
// NOTE: for SQLite use absolute path: 'sqlite:////full/path/to/sqlite.db?mode=0646'
$config['db_dsnw'] = 'pgsql://{{ hosting.db_user }}:{{ hosting.db_pass }}@{{ hosting.db_host }}:{{ hosting.db_port }}/{{ hosting.db_name }}';
$config['db_prefix'] = 'roundcube_';

$config['enable_installer'] = false;

// The mail host chosen to perform the log-in.
// Leave blank to show a textbox at login, give a list of hosts
// to display a pulldown menu or set one host as string.
// To use SSL/TLS connection, enter hostname with prefix ssl:// or tls://
// Supported replacement variables:
// %n - hostname ($_SERVER['SERVER_NAME'])
// %t - hostname without the first part
// %d - domain (http hostname $_SERVER['HTTP_HOST'] without the first part)
// %s - domain name after the '@' from e-mail address provided at login screen
// For example %n = mail.domain.tld, %t = domain.tld
$config['default_host'] = '{{ config.config.default_host }}';

$config['skin_logo'] = '{{ config.config.skin_logo }}';

// SMTP server host (for sending mails).
// To use SSL/TLS connection, enter hostname with prefix ssl:// or tls://
// If left blank, the PHP mail() function is used
// Supported replacement variables:
// %h - user's IMAP hostname
// %n - hostname ($_SERVER['SERVER_NAME'])
// %t - hostname without the first part
// %d - domain (http hostname $_SERVER['HTTP_HOST'] without the first part)
// %z - IMAP domain (IMAP hostname without the first part)
// For example %n = mail.domain.tld, %t = domain.tld
$config['smtp_server'] = '';

// SMTP port (default is 25; use 587 for STARTTLS or 465 for the
// deprecated SSL over SMTP (aka SMTPS))
$config['smtp_port'] = 25;

// SMTP username (if required) if you use %u as the username Roundcube
// will use the current username for login
$config['smtp_user'] = '';

// SMTP password (if required) if you use %p as the password Roundcube
// will use the current user's password for login
$config['smtp_pass'] = '';

// provide an URL where a user can get support for this Roundcube installation
// PLEASE DO NOT LINK TO THE ROUNDCUBE.NET WEBSITE HERE!
$config['support_url'] = '{{ config.config.support_url }}';

// Name your service. This is displayed on the login screen and in the window title
$config['product_name'] = '{{ config.config.product_name }}';

// this key is used to encrypt the users imap password which is stored
// in the session record (and the client cookie if remember password is enabled).
// please provide a string of exactly 24 chars.
// YOUR KEY MUST BE DIFFERENT THAN THE SAMPLE VALUE FOR SECURITY REASONS
$config['des_key'] = '{{ salt['grains.get_or_set_hash']('roundcube_des_key', 24) }}';

// List of active plugins (in plugins/ directory)
$config['plugins'] = array(
    'acl',  # shared imaps
    'archive',
    'managesieve',
    'markasjunk',
    'newmail_notifier',
    'subscriptions_option',
    'zipdownload',
    # 'enigma',
    # 'legacy_browser',
    # 'show_additional_headers',
    # 'additional_message_headers',
    # 'example_addressbook',
    # 'squirrelmail_usercopy',
    # 'filesystem_attachments',
    # 'attachment_reminder',
    # 'autologon',
    # 'hide_blockquote',
    # 'new_user_dialog',
    # 'vcard_attachments',
    # 'database_attachments',
    # 'http_authentication',
    # 'new_user_identity',
    # 'virtuser_file',
    # 'debug_logger',
    # 'identity_select',
    # 'virtuser_query',
    # 'emoticons',
    # 'redundant_attachments',

    # Todo ...
    # 'password',

    # Tested ...
    # 'help',
    # 'jqueryui',
    # 'userinfo',
);

// skin name: folder from skins/
$config['skin'] = 'larry';

$config['language'] = 'de_DE';
$config['enable_spellcheck'] = false;
$config['auto_create_user'] = false;

// Allow browser-autocompletion on login form.
// 0 - disabled, 1 - username and host only, 2 - username, host, password
$config['login_autocomplete'] = 1;

// Set identities access level:
// 0 - many identities with possibility to edit all params
// 1 - many identities with possibility to edit all params but not email address
// 2 - one identity with possibility to edit all params
// 3 - one identity with possibility to edit all params but not email address
// 4 - one identity with possibility to edit only signature
$config['identities_level'] = 3;

$config['drafts_mbox'] = 'Drafts';
$config['junk_mbox'] = 'Junk';
$config['sent_mbox'] = 'Sent';
$config['trash_mbox'] = 'Trash';

$config['delete_junk'] = true;

$config['create_default_folders'] = true;

$config['check_all_folders'] = false;

// use this format for date display (date or strftime format)
$config['date_format'] = 'd.m.Y';

// if in your system 0 quota means no limit set this option to true 
$config['quota_zero_as_unlimited'] = true;

$config['managesieve_script_name'] = 'Filter';
$config['managesieve_default'] = '/etc/dovecot/default.sieve';
