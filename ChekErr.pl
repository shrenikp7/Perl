#!/bin/perl
use strict;
use warnings;

chkerror();

################### Check Error ####################
sub chkerror
{
my @EXCLUDE="log_error_verbosity\|SSL library error\Can't read from messagefile";
my $hostname=`hostname`;
my $date=`date +%d%m%y_%H%M%S`;
my $MAIL_LIST="icanexoplre\@gmail.com ";
my $cmd = `grep -E  "error|corrupt|ERROR" /mysql/logs/<db_name>.err | egrep -vc "@EXCLUDE"`;
my $status = $cmd;
print $status;
if ($status != 0)
        {
        my $send_mail=`mailx -s "There is an error in MySQL error log for <db_name> on $hostname !! " $MAIL_LIST < /mysql/logs/<db_name>.err`;
        my $rename=`mv /mysql/<db_name>/logs/<db_name>.err  /mysql/logs/<db_name>.err.$date`;
        my $file=`touch /mysql/logs/<db_name>.err`
        }
}


## Add following in the crontab of mysql user
## Scan MySQL error log for <DB_NAME> and send notification
5,10,15,20,25,30,35,40,45,50,55 * * * * /mysql/admin/scripts/chk_err.pl >/dev/null 2>&1
