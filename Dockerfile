FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY "MvcApp.csproj" .
RUN dotnet restore "MvcApp.csproj"
COPY . .
RUN dotnet build . -c Release -o /app/build

RUN dotnet publish "MvcApp.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MvcApp.dll"][root@Kmaster asp.net_mvcapp]	
