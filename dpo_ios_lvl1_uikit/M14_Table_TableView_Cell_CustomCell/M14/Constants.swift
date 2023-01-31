//
//  Constants.swift
//  M14
//
//  Created by Николай Ногин on 26.07.2022.
//


enum Constants {
    
    enum Countries {
        static let imageAndName: [ [String: String] ] = [
            ["France": "Франция"],
            ["Austria": "Австрия"],
            ["Germany": "Германия"],
            ["Greece": "Греция"],
            ["Belgium": "Бельгия"]
        ]
    }
    
    enum News {
        static let Models: [NewsRecordModel] = [
            
            // 3 ITEMS - 25
            NewsRecordModel(
                title: "Airbus Ventures invests in Tokyo-based ispace",
                publishedAt: "2021-10-25T11:23:09.000Z"
            ),
            NewsRecordModel(
                title: "SpaceX fires up first upgraded Starship engine",
                publishedAt: "2021-10-25T09:13:32.000Z"
            ),
            NewsRecordModel(
                title: "IAI announces new small GEO satellite bus",
                publishedAt: "2021-10-25T08:33:11.000Z"
            ),
            
            // 6 ITEMS - 24
            NewsRecordModel(
                title: "Here’s how SpaceX is (probably) going to refuel Starships in space",
                publishedAt: "2021-10-24T19:53:33.000Z"
            ),
            NewsRecordModel(
                title: "Chang Zheng 3B lifts Shijian 21 to orbit",
                publishedAt: "2021-10-24T18:26:25.000Z"
            ),
            NewsRecordModel(
                title: "BepiColombo completes first Mercury flyby, science provides insight into planet’s unique environment",
                publishedAt: "2021-10-24T17:22:02.000Z"
            ),
            NewsRecordModel(
                title: "China launches classified space debris mitigation technology satellite",
                publishedAt: "2021-10-24T10:23:11.000Z"
            ),
            NewsRecordModel(
                title: "Arianespace breaks payload mass record on final Ariane 5 launch before Webb",
                publishedAt: "2021-10-24T08:13:08.000Z"
            ),
            NewsRecordModel(
                title: "Conference seeks to build interest in space among elected officials",
                publishedAt: "2021-10-24T02:23:10.000Z"
            ),
            
            // 3 ITEMS - 23
            NewsRecordModel(
                title: "Ariane 5 launches civilian, military satellites; mission to clear way for James Webb launch",
                publishedAt: "2021-10-23T21:10:54.000Z"
            ),
            NewsRecordModel(
                title: "Under watchful eye of NASA, teams prep for final Ariane 5 flight before Webb",
                publishedAt: "2021-10-23T19:13:07.000Z"
            ),
            NewsRecordModel(
                title: "NASA sets Artemis 1 launch for no earlier than February",
                publishedAt: "2021-10-23T03:33:12.000Z"
            ),
            
            
            // 8 ITEMS - 23
            NewsRecordModel(
                title: "L3 Harris wins $120 million contract to upgrade Space Force electronic jammers",
                publishedAt: "2021-10-22T23:13:11.000Z"
            ),
            NewsRecordModel(
                title: "NASA targets February launch for Artemis 1 moon mission",
                publishedAt: "2021-10-22T20:33:07.000Z"
            ),
            NewsRecordModel(
                title: "NASA Commits $28 Million to Underfunded US Jurisdictions",
                publishedAt: "2021-10-22T20:23:00.000Z"
            ),
            NewsRecordModel(
                title: "Ship 20 completes milestone RVac Static Fire – Musk cites ambitious path to launch",
                publishedAt: "2021-10-22T20:09:14.000Z"
            ),
            NewsRecordModel(
                title: "China’s hypersonic vehicle test a ‘significant demonstration’ of space technology",
                publishedAt: "2021-10-22T19:23:10.000Z"
            ),
            NewsRecordModel(
                title: "Space Adventures no longer planning Crew Dragon flight",
                publishedAt: "2021-10-22T19:23:10.000Z"
            ),
            NewsRecordModel(
                title: "NASA Invites Media to Launch of IXPE Mission to Study X-rays in Space",
                publishedAt: "2021-10-22T18:33:00.000Z"
            ),
            NewsRecordModel(
                title: "Ariane 5 launch delayed for more ground systems checks",
                publishedAt: "2021-10-22T16:43:06.000Z"
            )
        ]
    }
    
    enum NewsWithLocation {
        
        static let Models: [NewsWithLocationModel] = [
            // 7 ITEMS
            NewsWithLocationModel(
                name: "2017 NASA Astronaut class graduation ceremony",
                description: "NASA will honor the first class of astronaut candidates to graduate under the Artemis program at 10:30 a.m. EST Friday, Jan. 10, at the agency’s Johnson Space Center in Houston. After completing more than two years of basic training, these candidates will become eligible for spaceflight, including assignments to the International Space Station, Artemis missions to the Moon, and ultimately, missions to Mars.",
                location: "NASA's Johnson Space Center, Houston, TX, USA"
            ),
            NewsWithLocationModel(
                name: "70th International Astronautical Congress",
                description: "The International Astronautical Congress is a yearly conference where key figures in the space industry meet and showcase/discuss events in the spaceflight industry.\r\n\r\nThe event lasts starts on 21st October and lasts a week. Some of the panels will be live streamed for free on NASA TV.",
                location: "Washington D.C, United States"
              ),
            NewsWithLocationModel(
                name: "8th meeting of the National Space Council",
                description: "US Vice President Mike Pence will convene the 8th meeting of the National Space Council at NASA's Kennedy Space Center on December 9 at 12:30 p.m. ET. \r\n\r\nThe meeting will be livestreamed on NASA TV.",
                location: "Kennedy Space Center"
            ),
            NewsWithLocationModel(
                name: "Apollo 11th 50th Anniversary - Lunar Landing",
                description: "The United States' Apollo 11 was the first crewed mission to land on the Moon, on 20 July 1969. To date, the United States is the only country to have successfully conducted crewed missions to the Moon, with the last departing the lunar surface in December 1972.\r\n\r\nA total of twelve men have landed on the Moon. This was accomplished with two US pilot-astronauts flying a Lunar Module on each of six NASA missions across a 41-month period starting 20 July 1969 UTC, with Neil Armstrong and Buzz Aldrin on Apollo 11, and ending on 14 December 1972 UTC with Gene Cernan and Jack Schmitt on Apollo 17. Cernan was the last to step off the lunar surface.",
                location: "Lunar Surface"
            ),
            NewsWithLocationModel(
                name: "Apollo 12: 50th Anniversary Coverage",
                description: "Apollo 12 50th anniversary has a commemorative stream for the launch beginning at 11am EST. \r\n\r\nThe launch will take place at 11:42am.\r\n\r\n\"The second Apollo crew built on the work of the first. In addition to continuing Apollo's lunar exploration tasks they deployed the Apollo Lunar Surface Experiments Package, a set of investigations left on the Moon's surface to gather data. On their way to the Moon, the Apollo 12 crew conducted an orbital maneuver that let them land in the Moon's Western Hemisphere, so they could recover portions of a lander that had been on the moon for two years.\" - NASA",
                location: "NASA TV"
            ),
            NewsWithLocationModel(
                name: "Arianespace VV17 failure press conference",
                description: "8 minutes after liftoff of Vega mission VV17, following the first ignition of the engine of the Avum upper stage, a deviation of trajectory was identified, entailing the loss of the mission. There will be a press conference Tuesday, November 17th, 2020 at 10:00 am Kourou time / 2:00 pm Paris time.",
                location: "Guyana Space Center, Kourou, French Guiana"
            ),
            NewsWithLocationModel(
                name: "BepiColombo Earth Flyby",
                description: "The ESA-JAXA BepiColombo mission made a close approach of Earth on April 10, 2020 at 04:25 UTC. Gravity assist flybys are needed to set the spacecraft on course for Mercury orbit.",
                location: "Earth"
            )
        ]

    }

}
