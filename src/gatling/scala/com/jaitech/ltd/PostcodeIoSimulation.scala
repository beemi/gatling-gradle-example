package com.jaitech.ltd

import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder
import io.gatling.http.Predef.{http, status, _}
import io.gatling.http.protocol.HttpProtocolBuilder

class PostcodeIoSimulation extends Simulation {

  val httpProtocol: HttpProtocolBuilder = http
    .baseUrl("http://api.postcodes.io")
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .doNotTrackHeader("1")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:16.0) Gecko/20100101 Firefox/16.0")

  val feeder = csv("postcodes.csv").eager.random

  val scn: ScenarioBuilder = scenario("Get postcode lat long")
    .feed(feeder)
    .exec(
      http("/postcodes")
        .get("/postcodes/${postcode}")
        .check(status.is(200))
    )
    .pause(1)

  setUp(scn.inject(atOnceUsers(1)).protocols(httpProtocol))
}
