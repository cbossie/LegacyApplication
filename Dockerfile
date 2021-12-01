#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat 

# Build Container
FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019 AS build
WORKDIR /bld

# Copy Source to Build Container
COPY . .


WORKDIR /bld/LegacyApplication

RUN msbuild c:\bld\LegacyApplication.sln /t:Restore

# Execute Build
RUN msbuild c:\bld\LegacyApplication\LegacyApplication.csproj /p:PublishProfile=FolderProfile-C /p:DeployOnBuild=true 



# Copy from builder container to runner
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
WORKDIR /inetpub/wwwroot
COPY --from=build /Publish-Legacy .

# Create Virtual Directory and copy data
RUN c:\Windows\system32\inetsrv\appcmd.exe add vdir /app.name:"Default Web Site/" /path:/Images /physicalPath:"C:\images"

MAINTAINER Craig Bossie <cbbossie@amazon.com>


# Log Monitor Data
WORKDIR /LogMonitor
COPY /LegacyApplication/LogMonitor/LogMonitor.exe /LegacyApplication/LogMonitor/LogMonitorConfig.json ./
# Start IIS Remote Management and monitor IIS
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ENTRYPOINT ["C:\\LogMonitor\\LogMonitor.exe", "C:\\ServiceMonitor.exe", "w3svc"]

