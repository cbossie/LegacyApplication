
# Copy from builder container to runner
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Create Virtual Directory and copy data
RUN mkdir c:\\images
RUN icacls 'C:\Images\' /grant 'IIS APPPOOL\DefaultAppPool:(F)'

# Enable Failed Request Tracing
RUN Install-WindowsFeature Web-Http-Tracing
RUN ["C:\\Windows\\system32\\inetsrv\\appcmd.exe", "set", "config", "-section:system.applicationHost/sites", "/[name='Default Web Site'].traceFailedRequestsLogging.enabled:True", "/commit:apphost"]
RUN ["C:\\Windows\\system32\\inetsrv\\appcmd.exe", "set", "config", "-section:system.applicationHost/sites", "/[name='Default Web Site'].traceFailedRequestsLogging.maxLogFiles:10", "/commit:apphost"]
RUN ["C:\\Windows\\system32\\inetsrv\\appcmd.exe", "set", "config", "-section:system.applicationHost/sites", "/[name='Default Web Site'].traceFailedRequestsLogging.directory:C:\\inetpub\\logs\\FailedReqLogFiles\\", "/commit:apphost"]


RUN C:\Windows\system32\inetsrv\appcmd.exe add vdir /app.name:'Default Web Site/' /path:/Images /physicalPath:C:\images
MAINTAINER Craig Bossie <cbbossie@amazon.com>


# Log Monitor Data
WORKDIR /LogMonitor
COPY /LogMonitor/LogMonitor.exe /LogMonitor/LogMonitorConfig.json ./
# Start IIS Remote Management and monitor IIS
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ENTRYPOINT ["C:\\LogMonitor\\LogMonitor.exe", "C:\\ServiceMonitor.exe", "w3svc"]

