FROM openjdk:8
MAINTAINER Jonathan Vargas

# Set Environment Variables
ENV PDI_VERSION=9.2 \
    PDI_BUILD=9.2.0.0-290 \
	PENTAHO_HOME=/pentaho

WORKDIR $pentaho

RUN apt update && \	
    apt install -y ca-certificates wget

RUN update-ca-certificates

# Download PDI
RUN wget --progress=dot:giga https://razaoinfo.dl.sourceforge.net/project/pentaho/Pentaho-${PDI_VERSION}/server/pentaho-server-ce-${PDI_BUILD}.zip \
	&& unzip -q *.zip \
	&& rm -f *.zip \
    && chmod +x pentaho-server/start-pentaho.sh \
    && sed -i -e 's/\(exec ".*"\) start/\1 run/' pentaho-server/tomcat/bin/startup.sh
    
RUN cd pentaho-server/pentaho-solutions/system \
    && wget --progress=dot:giga https://ufpr.dl.sourceforge.net/project/datafor-visualizer/V3.3/datafor.zip \
	&& unzip -q *.zip \
	&& rm -f *.zip

EXPOSE 8080