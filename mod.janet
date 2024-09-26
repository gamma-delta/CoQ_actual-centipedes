#!/usr/bin/env janet

(use cbt-1.0.0)

(use /src/bodies)

(declare-mod
  "actual-centipedes"
  "Actual Centipedes"
  "petrak@"
  "0.1.0"
  :description "Makes centipedes actually have 100 legs. Please don't enable paper-doll inventory layout if you decide to dominate a centipede."
  :thumbnail "thumbnail.png"
  :steam-id 3338336391)

(generate-xml "Bodies.xml" bodies)
(generate-xml "ObjectBlueprints.xml"
              (fn [] [:objects
                      [:object {:Name "Giant Centipede" :Load "Merge"}
                       [:part {:Name "Body" :Anatomy "PK_ActualCentipede"}]]]))
