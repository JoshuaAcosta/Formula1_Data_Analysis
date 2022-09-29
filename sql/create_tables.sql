CREATE TABLE
  IF NOT EXISTS drivers (
    "driverId" serial PRIMARY KEY,
    "driverRef" VARCHAR(255) NOT NULL,
    "number" INT,
    "code" VARCHAR(7),
    "forename" VARCHAR(255) NOT NULL,
    "surname" VARCHAR(255) NOT NULL,
    "dob" DATE,
    "nationality" VARCHAR(255),
    "url" VARCHAR(255) UNIQUE NOT NULL
  );
  CREATE TABLE
  IF NOT EXISTS constructors (
    "constructorId" serial PRIMARY KEY,
    "constructorRef" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) UNIQUE NOT NULL,
    "nationality" VARCHAR(255),
    "url" VARCHAR(255) NOT NULL
  );
CREATE TABLE
  IF NOT EXISTS circuits (
    "circuitId" SERIAL PRIMARY KEY,
    "circuitRef" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "location" VARCHAR(255),
    "country" VARCHAR(255),
    "lat" REAL,
    "lng" REAL,
    "alt" INT,
    "url" VARCHAR(255) UNIQUE NOT NULL
  );
CREATE TABLE
  IF NOT EXISTS "seasons" (
    "year" serial PRIMARY KEY,
    "url" VARCHAR(255) UNIQUE NOT NULL
  );
CREATE TABLE
  IF NOT EXISTS "status" (
    "statusId" serial PRIMARY KEY NOT NULL,
    "status" VARCHAR(255) NOT NULL
  );
CREATE TABLE
  IF NOT EXISTS races (
    "raceId" serial PRIMARY KEY,
    "year" INT NOT NULL,
    "round" INT NOT NULL,
    "circuitId" INT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date" DATE NOT NULL,
    "time" TIME,
    "url" VARCHAR(255) UNIQUE,
    "fp1_date" DATE,
    "fp1_time" TIME,
    "fp2_date" DATE,
    "fp2_time" TIME,
    "fp3_date" DATE,
    "fp3_time" TIME,
    "quali_date" DATE,
    "quali_time" TIME,
    "sprint_date" DATE,
    "sprint_time" TIME,
    FOREIGN KEY ("year") REFERENCES seasons ("year"),
    FOREIGN KEY ("circuitId") REFERENCES circuits ("circuitId")
  );
CREATE TABLE
  IF NOT EXISTS qualifying (
    "qualifyId"serial PRIMARY KEY,
    "raceId" INT NOT NULL,
    "driverId" INT NOT NULL,
    "constructorId" INT NOT NULL,
    "number" INT NOT NULL,
    "position" INT,
    "q1" VARCHAR(255),
    "q2" VARCHAR(255),
    "q3" VARCHAR(255),
    FOREIGN KEY ("raceId") REFERENCES races ("raceId"),
    FOREIGN KEY ("driverId") REFERENCES drivers ("driverId"),
    FOREIGN KEY ("constructorId") REFERENCES constructors ("constructorId")
  );
CREATE TABLE
  IF NOT EXISTS sprint_results (
    "sprintResultId" serial PRIMARY KEY NOT NULL,
    "raceId" INT NOT NULL,
    "driverId" INT NOT NULL,
    "constructorId" INT NOT NULL,
    "number" INT,
    "grid" INT NOT NULL,
    "position" INT,
    "positionText" VARCHAR(255) NOT NULL,
    "positionOrder" INT NOT NULL,
    "points" REAL NOT NULL,
    "laps" INT NOT NULL,
    "time" VARCHAR(255),
    "milliseconds" INT,
    "fastestLap" INT,
    "fastestLapTime" VARCHAR(255),
    "statusId" INT NOT NULL,
    FOREIGN KEY ("raceId") REFERENCES races ("raceId"),
    FOREIGN KEY ("driverId") REFERENCES drivers ("driverId"),
    FOREIGN KEY ("constructorId") REFERENCES constructors ("constructorId"),
    FOREIGN KEY ("statusId") REFERENCES "status" ("statusId")
  );
CREATE TABLE
  IF NOT EXISTS results (
    "resultId" serial PRIMARY KEY,
    "raceId" INT NOT NULL,
    "driverId" INT NOT NULL,
    "constructorId" INT NOT NULL,
    "number" INT,
    "grid" INT NOT NULL,
    "position" INT,
    "positionText" VARCHAR(255) NOT NULL,
    "positionOrder" INT NOT NULL,
    "points" REAL NOT NULL,
    "laps" INT NOT NULL,
    "time" VARCHAR(255),
    "milliseconds" INT,
    "fastestLap" INT,
    "rank" INT,
    "fastestLapTime" VARCHAR(255),
    "fastestLapSpeed" VARCHAR(255),
    "statusId" INT NOT NULL,
    FOREIGN KEY ("raceId") REFERENCES races ("raceId"),
    FOREIGN KEY ("driverId") REFERENCES drivers ("driverId"),
    FOREIGN KEY ("constructorId") REFERENCES constructors ("constructorId"),
    FOREIGN KEY ("statusId") REFERENCES "status" ("statusId")
  );
CREATE TABLE
  IF NOT EXISTS pit_stops (
    "raceId" INT NOT NULL,
    "driverId" INT NOT NULL,
    "stop" INT,
    "lap" INT NOT NULL,
    "time" TIME NOT NULL,
    "duration" VARCHAR(255),
    "milliseconds" INT,
    FOREIGN KEY ("raceId") REFERENCES races ("raceId"),
    FOREIGN KEY ("driverId") REFERENCES drivers ("driverId"),
    PRIMARY KEY ("raceId", "driverId", "stop")
  );
CREATE TABLE
  IF NOT EXISTS lap_times(
    "raceId" INT NOT NULL,
    "driverId" INT NOT NULL,
    "lap" INT NOT NULL,
    "position" INT,
    "time" VARCHAR(255),
    "milliseconds" INT,
    FOREIGN KEY ("raceId") REFERENCES races ("raceId"),
    FOREIGN KEY ("driverId") REFERENCES drivers ("driverId"),
    PRIMARY KEY ("raceId", "driverId", "lap")
  );
CREATE TABLE
  IF NOT EXISTS driver_standings (
    "driverStandingsId" serial PRIMARY KEY,
    "raceId" INT NOT NULL,
    "driverId" INT NOT NULL,
    "points" REAL NOT NULL,
    "position" INT,
    "positionText" VARCHAR(255),
    "wins" INT NOT NULL,
    FOREIGN KEY ("raceId") REFERENCES races ("raceId"),
    FOREIGN KEY ("driverId") REFERENCES drivers ("driverId")
  );
CREATE TABLE
  IF NOT EXISTS constructor_standings (
    "constructorStandingsId" SERIAL PRIMARY KEY,
    "raceId" INT NOT NULL,
    "constructorId" INT NOT NULL,
    "points" REAL,
    "position" INT,
    "positionText" VARCHAR(255),
    "wins" INT NOT NULL,
    FOREIGN KEY ("raceId") REFERENCES races ("raceId"),
    FOREIGN KEY ("constructorId") REFERENCES constructors ("constructorId")
  );
CREATE TABLE
  IF NOT EXISTS constructor_results (
    "constructorResultsId" SERIAL PRIMARY KEY,
    "raceId" INT NOT NULL,
    "constructorId" INT NOT NULL,
    "points" REAL,
    "status" VARCHAR(255),
    FOREIGN KEY ("raceId") REFERENCES races ("raceId"),
    FOREIGN KEY ("constructorId") REFERENCES constructors ("constructorId")
  );
