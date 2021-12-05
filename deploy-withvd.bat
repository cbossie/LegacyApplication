




docker build -t iis-dotnetframework:build .

docker run -p 8081:80 -v "C:\images\:C:\images\"  -t iis-dotnetframework:build














docker run -p 8081:80 -v "C:\inetpub\images:D:\images"  -t iis-dotnetframework:build


c:\Windows\system32\inetsrv\appcmd.exe add vdir /app.name:"ASPNET40/" /path:/Images /physicalPath:"C:\images"
c:\Windows\system32\inetsrv\appcmd.exe add vdir /app.name:'ASPNET40/' /path:/Images /physicalPath:'C:\images'

c:\Windows\system32\inetsrv\appcmd.exe list vdirs




