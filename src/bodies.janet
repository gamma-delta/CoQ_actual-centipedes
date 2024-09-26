(defn- ordinal-string [num]
  (def under20 {1 "First" 2 "Second" 3 "Third" 4 "Fourth" 5 "Fifth"
                6 "Sixth" 7 "Seventh" 8 "Eighth" 9 "Ninth" 10 "Tenth"
                11 "Eleventh" 12 "Twelfth" 13 "Thirteenth" 14 "Fourteenth" 15 "Fifteenth"
                16 "Sixteenth" 17 "Seventeenth" 18 "Eighteenth" 19 "Ninteenth"})
  (def tens-cardinal {2 "Twenty" 3 "Thirty" 4 "Forty" 5 "Fifty"
                      6 "Sixty" 7 "Seventy" 8 "Eighty" 9 "Ninety"})
  (def tens-ordinal {10 "Tenth" 20 "Twentieth" 30 "Thirtieth" 40 "Fortieth" 50 "Fiftieth"
                     60 "Sixtieth" 70 "Seventieth" 80 "Eightieth" 90 "Ninetieth"})

  (let [rem10 (% num 10) div10 (div num 10)]
    (cond
      (< num 20) (in under20 num)
      (= rem10 0) (in tens-ordinal num)
      (string (in tens-cardinal div10) "-" (in under20 rem10)))))

(def- ordinals
  (seq [idx :range [0 50]] (ordinal-string (+ idx 1))))

# Unfortunately lateralities are hard-coded Waugh

(defn- legsplat [count]
  (catseq [idx :range [0 count]]
          (def limb-position
            (cond
              (= idx 0) "Fore"
              (= idx (- count 1)) "Hind"
              (ordinal-string (+ idx 1))))
          (def support (string limb-position " Legs"))
          (def each-leg
            (seq [side :in ["Left" "Right"]]
              [:part {:Type "Leg"
                      :Laterality (string side " " limb-position)
                      :SupportsDependent support}]))
          (def legs [:part {:Type "Legs" :Laterality limb-position :DependsOn support}])

          [;each-leg legs]))

(defn bodies []
  [:bodies
   [:bodyparttypevariants
    ;(catseq [ord :in ordinals]
             [[:bodyparttypevariant {:VariantOf "Arm" :Type (string ord " Leg")
                                     :LimbBlueprintProperty "SeveredLegBlueprint" :Mobility 1}]
              [:bodyparttypevariant {:VariantOf "Feet" :Type (string ord " Legs")
                                     :LimbBlueprintProperty "SeveredLegBlueprint" :Mobility 0}]])]

   [:anatomies
    [:anatomy {:Name "PK_ActualCentipede" :Category "Arthropod"}
     [:part {:Type "Head"}
      [:part {:Type "Antennae"}]]
     [:part {:Type "Back"}]
     [:part {:Type "Missile Weapon" :Laterality "Right"}]
     [:part {:Type "Missile Weapon" :Laterality "Left"}]
     ;(catseq [ord :in ordinals]
              (def support (string ord " Legs Support"))
              (def each-leg
                (seq [side :in ["Right" "Left"]]
                  [:part {:Type (string ord " Leg") :Laterality side :SupportsDependent support}]))
              (def legs-together
                [:part {:Type (string ord " Legs") :Depends support}])
              [;each-leg legs-together])]]])
