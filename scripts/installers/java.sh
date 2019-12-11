#!/bin/bash
################################################################################
##  File:  java.sh
##  Team:  CI-Platform
##  Desc:  Installs java and gradle
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

mkdir -p /usr/lib/jvm
tar -zxf /tmp/jdk.tar.gz -C /usr/lib/jvm/
cd /usr/lib/jvm/jdk*/
JDK_DIR=`pwd`

echo "JAVA_HOME=${JDK_DIR}" | tee -a /etc/environment
echo "JAVA_HOME_8_X64=${JDK_DIR}" | tee -a /etc/environment
echo "JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8" | tee -a /etc/environment
update-java-alternatives -s ${JDK_DIR}

# Install Gradle
# This script downloads the latest HTML list of releases at https://gradle.org/releases/.
# Then, it extracts the top-most release download URL, relying on the top-most URL being for the latest release.
# The release download URL looks like this: https://services.gradle.org/distributions/gradle-5.2.1-bin.zip
# The release version is extracted from the download URL (i.e. 5.2.1).
# After all of this, the release is downloaded, extracted, a symlink is created that points to it, and GRADLE_HOME is set.
wget -O gradleReleases.html https://gradle.org/releases/
gradleUrl=$(grep -m 1 -o "https:\/\/services.gradle.org\/distributions\/gradle-.*-bin\.zip" gradleReleases.html | head -1)
gradleVersion=$(echo $gradleUrl | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p')
rm gradleReleases.html
echo "gradleUrl=$gradleUrl"
echo "gradleVersion=$gradleVersion"
curl -sL $gradleUrl -o gradleLatest.zip
unzip -d /usr/share gradleLatest.zip
rm gradleLatest.zip
ln -s /usr/share/gradle-"${gradleVersion}"/bin/gradle /usr/bin/gradle
echo "GRADLE_HOME=/usr/share/gradle" | tee -a /etc/environment

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in gradle java javac; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or found on path"
        exit 1
    fi
done

echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Java ($(${JDK_DIR} -version |& head -n 1))"

