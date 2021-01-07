#######################################################
# Step 1: Build the application in a container        #
#######################################################
# Download the official ASP.NET Core SDK image
# to build the project while creating the docker image

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build

# Passing Arguments
ARG SONAR_PROJECT_KEY=test
ARG SONAR_OGRANIZAION_KEY=robinmanuelthiel
ARG SONAR_HOST_URL=http://13.82.230.104:9000
ARG SONAR_TOKEN=9a3a91fbfa666ad5196d6e6ac5928bbe3adbfdc4

WORKDIR /app



# RUN dotnet sonarscanner begin \
#   /k:"$SONAR_PROJECT_KEY" \
#   /o:"$SONAR_OGRANIZAION_KEY" \
#   /d:sonar.host.url="$SONAR_HOST_URL" \
#   /d:sonar.login="$SONAR_TOKEN" \
#   /d:sonar.cs.opencover.reportsPaths=/coverage.opencover.xml

# Restore NuGet packages

COPY . .
#COPY BackendService2/BackendService2.csproj BackendService2/BackendService2.csproj
#COPY BackendService2.Tests/BackendService2.Tests.csproj BackendService2.Tests/BackendService2.Tests.csproj
RUN dotnet tool install dotnet-reportgenerator-globaltool --version 4.0.6 --tool-path /tools
RUN dotnet test --results-directory /testresults --logger "trx;LogFileName=test_results.xml" /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura /p:CoverletOutput=/testresults/coverage/ /p:Exclude="[xunit.*]*%2c[StackExchange.*]*" BackendService2.Tests/BackendService2.Tests.csproj
WORKDIR /src


# Install Sonar Scanner, Coverlet and Java (required for Sonar Scanner)
RUN apt-get update && apt-get install -y openjdk-11-jdk -qq
RUN dotnet tool install --global dotnet-sonarscanner
RUN dotnet tool install --global coverlet.console
ENV PATH="$PATH:/root/.dotnet/tools"

WORKDIR  /app/BackendService2

# Start Sonar Scanner
RUN dotnet sonarscanner begin \
    /k:"$SONAR_PROJECT_KEY" \
    /d:sonar.host.url="$SONAR_HOST_URL" \
    /d:sonar.login="$SONAR_TOKEN"

RUN dotnet restore

#COPY . .

# Build and test the application
RUN dotnet publish -c Release -r alpine-x64 --self-contained true /p:PublishTrimmed=true -o ./publish

# RUN dotnet test \
#   /p:CollectCoverage=true \
#   /p:CoverletOutputFormat=opencover \
#   /p:CoverletOutput="/coverage"

# End Sonar Scanner
RUN dotnet sonarscanner end /d:sonar.login="$SONAR_TOKEN"

#######################################################
# Step 2: Run the build outcome in a container        #
#######################################################
# to run the compiled application in alpine image

FROM alpine
RUN apk add --no-cache libstdc++ libintl icu
RUN apk add --no-cache \ 
openssh libunwind \
    nghttp2-libs libidn krb5-libs libuuid lttng-ust zlib \
    libstdc++ libintl \
    icu
WORKDIR /app

# Open port
EXPOSE 8080

# Copy the build output from the SDK image
COPY --from=build /app/BackendService2/publish ./

# Start the application
ENTRYPOINT ["./BackendService2", "--urls", "http://0.0.0.0:8080"]
