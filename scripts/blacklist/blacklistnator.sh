#!/bin/sh
# Check if an IP address is listed on one of the following blacklists
# The format is chosen to make it easy to add or delete
# The shell will strip multiple whitespace
 
BLISTS="
bl.score.senderscore.com
bl.mailspike.net
b.barracudacentral.org
bl.spamcop.net
cdl.anti-spam.org.cn
dnsbl-1.uceprotect.net
dnsbl-2.uceprotect.net
dnsbl-3.uceprotect.net
dnsbl.sorbs.net
dul.dnsbl.sorbs.net
dyna.spamrats.com
http.dnsbl.sorbs.net
misc.dnsbl.sorbs.net
pbl.spamhaus.org
phishing.rbl.msrbl.net
probes.dnsbl.net.au
sbl.spamhaus.org
socks.dnsbl.sorbs.net
spam.rbl.msrbl.net
spam.spamrats.com
ubl.lashback.com
ubl.unsubscore.com
virus.rbl.msrbl.net
web.dnsbl.sorbs.net
xbl.spamhaus.org
zen.spamhaus.org
"
 
# simple shell function to show an error message and exit
#  $0  : the name of shell script, $1 is the string passed as argument
# >&2  : redirect/send the message to stderr
 
ERROR() {
      echo $0 ERROR: $1 >&2
        exit 2
    }
 
    # -- Sanity check on parameters
    [ $# -ne 1 ] && ERROR 'Please specify a single IP address'
 
    # -- if the address consists of 4 groups of minimal 1, maximal digits, separated by '.'
    # -- reverse the order
    # -- if the address does not match these criteria the variable 'reverse will be empty'
 
    reverse=$(echo $1 |
      sed -ne "s~^\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)$~\4.\3.\2.\1~p")
 
      if [ "x${reverse}" = "x" ] ; then
                ERROR  "IMHO '$1' doesn't look like a valid IP address"
                  exit 1
          fi
 
          # Assuming an IP address of 11.22.33.44 as parameter or argument
 
          # If the IP address in $0 passes our crude regular expression check,
          # the variable  ${reverse} will contain 44.33.22.11
          # In this case the test will be:
          #   [ "x44.33.22.11" = "x" ]
          # This test will fail and the program will continue
 
          # An empty '${reverse}' means that shell argument $1 doesn't pass our simple IP address check
          # In that case the test will be:
          #   [ "x" = "x" ]
          # This evaluates to true, so the script will call the ERROR function and quit
 
          # -- do a reverse ( address -> name) DNS lookup
          REVERSE_DNS=$(dig +short -x $1)
 
          echo IP $1 NAME ${REVERSE_DNS:----}
 
          # -- cycle through all the blacklists
          for BL in ${BLISTS} ; do
                  # show the reversed IP and append the name of the blacklist
                      printf "%-60s" " ${reverse}.${BL}."
 
                      # use dig to lookup the name in the blacklist
                          #echo "$(dig +short -t a ${reverse}.${BL}. |  tr '\n' ' ')"
                          LISTED="$(dig +short -t a ${reverse}.${BL}.)"
                              echo ${LISTED:----}
                      done
