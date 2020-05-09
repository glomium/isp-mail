require ["fileinto", "mailbox"];
# rule:[Spam]
if header :is "x-spam-flag" "YES"
{
	fileinto :create "Junk";
	stop;
}
