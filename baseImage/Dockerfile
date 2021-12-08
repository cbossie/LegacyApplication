
# Copy from builder container to runner
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

ARG CERTPASS

EXPOSE 80
EXPOSE 443

# Create Virtual Directory and copy data
RUN mkdir c:\\images
RUN icacls 'C:\Images\' /grant 'IIS APPPOOL\DefaultAppPool:(F)'

# Enable Failed Request Tracing
RUN Install-WindowsFeature Web-Http-Tracing
RUN ["C:\\Windows\\system32\\inetsrv\\appcmd.exe", "set", "config", "-section:system.applicationHost/sites", "/[name='Default Web Site'].traceFailedRequestsLogging.enabled:True", "/commit:apphost"]
RUN ["C:\\Windows\\system32\\inetsrv\\appcmd.exe", "set", "config", "-section:system.applicationHost/sites", "/[name='Default Web Site'].traceFailedRequestsLogging.maxLogFiles:10", "/commit:apphost"]
RUN ["C:\\Windows\\system32\\inetsrv\\appcmd.exe", "set", "config", "-section:system.applicationHost/sites", "/[name='Default Web Site'].traceFailedRequestsLogging.directory:C:\\inetpub\\logs\\FailedReqLogFiles\\", "/commit:apphost"]

# Import SSL
WORKDIR /
COPY /domain.pfx /domain.pfx
RUN certutil -p "$env:CERTPASS" -importPfx .\domain.pfx
COPY /rootCA.crt /rootCA.crt
RUN certutil -addstore "CA" "c:\rootCA.crt"
RUN certutil -addstore "Root" "c:\rootCA.crt"

# Add HTTPS Binding to the Site
RUN ["C:\\Windows\\system32\\inetsrv\\appcmd.exe", "set", "site", "/site.name:Default Web Site", "/+bindings.[protocol='https',bindingInformation='*:443:']"]
RUN netsh http add sslcert ipport=0.0.0.0:443 certhash='4e1f0c5dd1fa33820feb92f5de3c0c63847c7e60' appid='{ab3c58f7-8316-42e3-bc6e-771d4ce4b202}'

# Add Virtual directory
RUN C:\Windows\system32\inetsrv\appcmd.exe add vdir /app.name:'Default Web Site/' /path:/Images /physicalPath:C:\images
MAINTAINER Craig Bossie <cbbossie@amazon.com>


# Log Monitor Data
WORKDIR /LogMonitor
COPY /LogMonitor/LogMonitor.exe /LogMonitor/LogMonitorConfig.json ./
# Start IIS Remote Management and monitor IIS
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ENTRYPOINT ["C:\\LogMonitor\\LogMonitor.exe", "C:\\ServiceMonitor.exe", "w3svc"]

