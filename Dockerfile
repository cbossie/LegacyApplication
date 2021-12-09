#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat 

# Build Container
FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019 AS build
WORKDIR /bld

# Copy Source to Build Container
COPY . .
WORKDIR /bld/LegacyApplication

# Execute Build
RUN nuget restore c:\bld\LegacyApplication\LegacyApplication.csproj -PackagesDirectory c:\bld\packages
#RUN msbuild c:\bld\LegacyApplication\LegacyApplication\LegacyApplication.csproj /t:restore
WORKDIR /bld/LegacyApplication/LegacyApplication
RUN msbuild c:\bld\LegacyApplication\LegacyApplication.csproj /p:PublishProfile=FolderProfile-C /p:DeployOnBuild=true

# Copy from builder container to runner
FROM iis-base-image:prod
WORKDIR /inetpub/wwwroot
COPY --from=build /Publish-Legacy .



