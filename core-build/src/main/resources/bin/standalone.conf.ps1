### -*- Power Shell file -*- ################################################
#                                                                          ##
#  JBoss Bootstrap Script Configuration                                    ##
#                                                                          ##
#############################################################################

#
# This script file is executed by run.bat to initialize the environment
# variables that run.bat uses. It is recommended to use this file to
# configure these variables, rather than modifying run.bat itself.
#


# Uncomment the following line to disable manipulation of JAVA_OPTS (JVM parameters)
# Set-Env PRESERVE_JAVA_OPTS true

if( Test-Path env:JAVA_OPTS ) {
  $JAVA_OPTS = Get-Env JAVA_OPTS
  echo "JAVA_OPTS already set in environment; overriding default settings with values: $JAVA_OPTS"
  return
}

#
# Specify the JBoss Profiler configuration file to load.
#
# Default is to not load a JBoss Profiler configuration file.
#
# Set-Env PROFILER $JBOSS_HOME\bin\jboss-profiler.properties

#
# Specify the location of the Java home directory (it is recommended that
# this always be set). If set, then "%JAVA_HOME%\bin\java" will be used as
# the Java VM executable; otherwise, "%JAVA%" will be used (see below).
#
# Set-Env JAVA_HOME C:\opt\jdk1.6.0_23

#
# Specify the exact Java VM executable to use - only used if JAVA_HOME is
# not set. Default is "java".
#
# Set-Env JAVA C:\opt\jdk1.6.0_23\bin\java

#
# Specify options to pass to the Java VM. Note, there are some additional
# options that are always passed by run.bat.
#
$JAVA_OPTS = @('')

# JVM memory allocation pool parameters - modify as appropriate.
$JAVA_OPTS += '-Xms64M'
$JAVA_OPTS += '-Xmx512M'
$JAVA_OPTS += '-XX:MaxPermSize=256M'

# Reduce the RMI GCs to once per hour for Sun JVMs.
$JAVA_OPTS += '-Dsun.rmi.dgc.client.gcInterval=3600000'
$JAVA_OPTS += '-Dsun.rmi.dgc.server.gcInterval=3600000'
$JAVA_OPTS += '-Djava.net.preferIPv4Stack=true'

# Warn when resolving remote XML DTDs or schemas.
$JAVA_OPTS += '-Dorg.jboss.resolver.warning=true'

# Make Byteman classes visible in all module loaders
# This is necessary to inject Byteman rules into AS7 deployments
$JAVA_OPTS += '-Djboss.modules.system.pkgs=org.jboss.byteman'

# Set the default configuration file to use if -c or --server-config are not used
$JAVA_OPTS += '-Djboss.server.default.config=standalone.xml'

# Sample JPDA settings for remote socket debugging
# $JAVA_OPTS += '-Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n'

# Sample JPDA settings for shared memory debugging
# $JAVA_OPTS += '-Xrunjdwp:transport=dt_shmem,address=jboss,server=y,suspend=n'

# Use JBoss Modules lockless mode
# $JAVA_OPTS += '-Djboss.modules.lockless=true'
