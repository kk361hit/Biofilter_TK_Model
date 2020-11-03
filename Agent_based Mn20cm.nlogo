turtles-own [Name Pos Cellweight Group C tdd subs ECS EEG MO]  ; C for inherent characteristic, tdd for variable thermodynamics and kinetics parameters, subs: substrate for cell synthesis, Pos:Position of cell, ECS:electron for energy generation ECS: electron for cell synthesis
breed [Microbes Microbe]

globals
[
  Temp
  Volume
  C6H12O6
  C2H5COO
  CH3COO
  Fe2
  Fe3
  Mn2
  MnO2
  NH3
  NO2
  NO3
  HS
  S2O32
  SO42
  SO32
  O2
  N2
  CO2
  hh
  COD
  time
  time1
  i
  unit_hight
  Step_Time
  H_L
]

to setup
  clear-all
  file-close-all
  set H_L hydraulic_loading
  set Step_Time 0.2 / (H_L / 60) / 2
  set C6H12O6 [0 0 0 0 0]
  set C2H5COO [0 0 0 0 0]
  set CH3COO [0 0 0 0 0]
  set CO2 [0 0 0 0 0]
  set Fe2 [0 0 0 0 0]
  set Fe3 [0 0 0 0 0]
  set hh [0 0 0 0 0]
  set Mn2 [0 0 0 0 0]
  set MnO2 [0 0 0 0 0]
  set N2 [0 0 0 0 0]
  set NH3 [0 0 0 0 0]
  set NO2 [0 0 0 0 0]
  set NO3 [0 0 0 0 0]
  set O2 [0 0 0 0 0]
  set HS [0 0 0 0 0]
  set S2O32 [0 0 0 0 0]
  set SO42 [0 0 0 0 0]
  set SO32 [0 0 0 0 0]
  set COD [0 0 0 0 0]
  setup-globals
  setup-microorganism
  ask patches with [((pycor > 298) and (pycor < 302)) xor ((pycor > 98) and (pycor < 102)) xor ((pycor > -102) and (pycor < -98)) xor ((pycor > -302) and (pycor < -298))]
    [ set pcolor white ]
  reset-ticks
end


to setup-globals
  set time 0
  set time1 0
  set Volume pi * 3 * 3 * 20 / 1000 ; L
  set unit_hight 0.2 ; m
  set Temp Temperature + 273.15
  set i 0
  while [i < 5]
  [
    set C6H12O6 replace-item i C6H12O6 (Initial-Glucose * Volume + 0.0000001)
    set C2H5COO replace-item i C2H5COO (Initial-Propionate * Volume + 0.0000001)
    set CH3COO replace-item i CH3COO (Initial-Acetate * Volume + 0.0000001)
    set CO2 replace-item i CO2 (Initial-CO2 * Volume + 0.0000001)
    set hh replace-item i hh (10 ^ ( - pH ) * Volume)
    set Fe2 replace-item i Fe2 (Initial-Fe2  * Volume + 0.0000001)
    set Fe3 replace-item i Fe3 (Initial-Fe3 * Volume + 0.0000001)
    set Mn2 replace-item i Mn2 (Initial-Mn2 * Volume + 0.0000001)
    set MnO2 replace-item i MnO2 (Initial-MnO2 * Volume + 0.0000001)
    set N2 replace-item i N2 (Initial-N2 * Volume + 0.0000001)
    set NH3 replace-item i NH3 (Initial-NH3 * Volume + 0.0000001)
    set NO2 replace-item i NO2 (Initial-NO2 * Volume + 0.0000001)
    set NO3 replace-item i NO3 (Initial-NO3 * Volume + 0.0000001)
    set O2 replace-item i O2 (Initial-O2 * Volume + 0.0000001)
    set HS replace-item i HS (Initial-HS * Volume + 0.0000001)
    set S2O32 replace-item i S2O32 (Initial-S2O3 * Volume + 0.0000001)
    set SO42 replace-item i SO42 (Initial-SO4 * Volume + 0.0000001)
    set SO32 replace-item i SO32 (Initial-SO3 * Volume + 0.0000001)
    set i i + 1
  ]
  display
  update-plots
end

to setup-microorganism
  set i 0
  while [i < 5]
  [
    create-Microbes initial-reaction-1 * Volume / InitialCellweight
    [
      set Group "Fermentative bacteria"
      set Name "reaction-1"
      set shape "default"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-2 * Volume / InitialCellweight
    [
      set Group "Fermentative bacteria"
      set Name "reaction-2"
      set shape "x"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-3 * Volume / InitialCellweight
    [
      set Group "Exoelectrogens"
      set Name "reaction-3"
      set shape "apple"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-4 * Volume / InitialCellweight
    [
      set Group "Exoelectrogens"
      set Name "reaction-4"
      set shape "wheel"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-5 * Volume / InitialCellweight
    [
      set Group "Exoelectrogens"
      set Name "reaction-5"
      set shape "leaf 2"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-6 * Volume / InitialCellweight
    [
      set Group "Methanogens"
      set Name "reaction-6"
      set shape "arrow"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-7 * Volume / InitialCellweight
    [
      set Group "Methanogens"
      set Name "reaction-7"
      set shape "bug"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-8 * Volume / InitialCellweight
    [
      set Group "Hydrogen producing bacteria"
      set Name "reaction-8"
      set shape "circle"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-9 * Volume / InitialCellweight
    [
      set Group "Hydrogen producing bacteria"
      set Name "reaction-9"
      set shape "circle 2"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-10 * Volume / InitialCellweight
    [
      set Group "Hydrogen producing bacteria"
      set Name "reaction-10"
      set shape "leaf"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-11 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-11"
      set shape "pentagon"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-12 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-12"
      set shape "plant"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-13 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-13"
      set shape "square"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-14 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-14"
      set shape "square 2"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-15 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-15"
      set shape "star"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-16 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-16"
      set shape "cloud"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-17 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-17"
      set shape "caterpillar"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-18 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-18"
      set shape "banana"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-19 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-19"
      set shape "petals"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-20 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-20"
      set shape "drop"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-21 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-21"
      set shape "tooth"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    create-Microbes initial-reaction-22 * Volume / InitialCellweight
    [
      set Group "Sulfate reducing bacteria"
      set Name "reaction-22"
      set shape "egg"
      setxy random-xcor (500 - ((random 198 + 1 ) + 200 * i))
    ]
    set i i + 1
  ]
  ask Microbes with [Group = "Fermentative bacteria"]
  [
    set color 95
  ]
  ask Microbes with [Group = "Exoelectrogens"]
  [
    set color 15
  ]
  ask Microbes with [Group = "Methanogens"]
  [
    set color 45
  ]
  ask Microbes with [Group = "Hydrogen producing bacteria"]
  [
    set color 65
  ]
  ask Microbes with [Group = "Sulfate reducing bacteria"]
  [
    set color 115
  ]
  ask Microbes with [Group = "Sulfur oxidizing bacteria"]
  [
    set color 135
  ]
  ask turtles
  [
    set Pos (ceiling ( - (ycor - 500) / 200) ) - 1
    set Cellweight InitialCellweight
    set size Cellweight / InitialCellweight * 2
    set C SetCharacteristics Name
    set tdd [0 0 0 0 0]
  ]
end

to-report SetCharacteristics [a] ;;;read input file
  file-open "characteristics.csv"
  if file-at-end?
  [
    file-close
    error "Empty file"
  ]
  let CH []
  let csv file-read-line
  if csv != "Species,Ga0',Gc0',Gpc,Ks,eN,b,C6H12O6,C2H5COO-,CH3COO-,Fe2+,Fe3+,Mn2+,MnO2,NH3,NO2-,NO3-,HS- ,S2O32- ,SO42- ,SO32- ,O2,N2,CO2,H+,H2O"
  [
    file-close
    error "Wrong input!"
  ]
  set csv file-read-line
  set csv word csv ","  ; add semicolon for loop termination
  let mylist []  ; list of values
  while [empty? CH and not empty? csv]
  [
    let $x position "," csv
    let $item substring csv 0 $x  ; extract item
    ifelse $item = a
    [
      while [not empty? csv]
      [
        set $x position "," csv
        set $item substring csv 0 $x  ; extract item
        carefully [set $item read-from-string $item][] ; convert if number
        set mylist lput $item mylist  ; append to list
        set csv substring csv ($x + 1) length csv  ; remove item and comma
      ]
      set CH mylist
    ]
    [
      if file-at-end?
      [
        let EM word "Cannot find " a
        file-close
        error EM
      ]
      set csv file-read-line
      set csv word csv ","  ; add semicolon for loop termination
    ]
  ]
  set CH lput 0 CH
  set CH lput 0 CH
  file-close
  report CH
end

to go
  set H_L hydraulic_loading
  set Step_Time 0.2 / (H_L / 60) / 2
  ask turtles ;; includes all breeds
  [
    move
    Calculate
    metabolism
    reproduce
    combine
    set size Cellweight / InitialCellweight * 2
  ]
  if time - time1 > update_time
  [
    display
    update-plots
    set time1 time
  ]
  set i 0
  while [i < 5]
  [
    set COD replace-item i COD ((item i c6h12o6 * 12 + item i c2h5coo * 7 + item i ch3coo * 4 + item i HS * 4 + item i SO32 * 1 + item i S2O32 * 5 + item i fe2 * 1  + item i Mn2 * 2) * 16 / Volume)  ;COD calculation
    set i i + 1
  ]
  flow
  set time time + Step_Time
  if sum [Cellweight] of turtles / Volume < (InitialCellweight / 10) [stop]
  if StopTime != 0
  [
    if time > StopTime [stop]
  ]
end

to Calculate
  set tdd setTD C Pos
end

to-report setTD [CH p]  ;calculate for ∆fG', fe0, fs0, Y, Ê, ΔX/t
  let TD []
  set TD lput (item 1 CH + 0.008314 * Temp  * ( ln (item p C6H12O6 ^ item 7 CH ) + ln ( item p C2H5COO ^ item 8 CH ) + ln ( item p CH3COO ^ item 9 CH ) + ln ( item p Fe2 ^ item 10 CH ) + ln ( item p Fe3 ^ item 11 CH ) + ln ( item p Mn2 ^ item 12 CH ) + ln ( item p NH3 ^ item 14 CH ) + ln ( item p NO2 ^ item 15 CH ) + ln ( item p NO3 ^ item 16 CH ) + ln ( item p HS ^ item 17 CH ) + ln ( item p S2O32 ^ item 18 CH ) + ln ( item p SO42 ^ item 19 CH ) + ln ( item p SO32 ^ item 20 CH ) + ln ( item p O2 ^  item 21 CH ) + ln ( item p N2 ^ item 22 CH ) + ln ( item p CO2 ^  item 23 CH ) + ln ( ( 10 ^ (- pH)) ^ (item 24 CH))) - 0.008314 * Temp  * ln (( 10 ^ -7) ^ ( item 24 CH)) ) TD ;Gr kJ/mEq
  set TD lput (( - ((35.09 - item 2 CH) / (EnergyTransferEfficiency ^ ((35.09 - item 2 CH) / (abs (35.09 - item 2 CH)))) + item 3 CH / EnergyTransferEfficiency) / (EnergyTransferEfficiency * item 0 TD)) / (1 + ( - ((35.09 - item 2 CH) / (EnergyTransferEfficiency ^ ((35.09 - item 2 CH) / (abs (35.09 - item 2 CH)))) + item 3 CH / EnergyTransferEfficiency) / (EnergyTransferEfficiency * item 0 TD)))) TD ;Fe0
  set TD lput ( 1 - item 1 TD ) TD ;fs0
  set TD lput ( item 2 TD  / item 5 CH * 113 ) TD ;Y (mg cell / mEq)
  set TD lput ((1 / 24 ) / item 1 TD) TD; Ê ( mEq reaction/mg cell -h)
  set TD lput (item 3 TD * item 4 TD)  TD ; ΔX/t (-h) =Y*Ê
  report TD
end

to metabolism  ;; turtle procedure
  set MO 0 ; monod coefficient
  set subs [0 0 0 0 0 0 0 0] ; glucose, acetate, propionate,co2 NH3,NO3,NO2,N2 for setting the carbon source of cell synthesis
  if Name = "reaction-1" or Name = "reaction-2" or Name = "reaction-5" or Name = "reaction-6"
  [
    set MO ( item Pos Mn2  / Volume ) / ( item 4 C + item Pos Mn2 / Volume )            ; monod equation
  ]
  if Name = "reaction-3" or Name = "reaction-4" or Name = "reaction-7" or Name = "reaction-8"
  [
    set MO ( item Pos Fe2  / Volume ) / ( item 4 C + item Pos Fe2 / Volume )            ; monod equation
  ]
  if Name = "reaction-9" or Name = "reaction-10"
  [
    set MO ( item Pos NH3  / Volume ) / ( item 4 C + item Pos NH3 / Volume )            ; monod equation
  ]
  if Name = "reaction-11"
  [
    set MO ( item Pos NO2  / Volume ) / ( item 4 C + item Pos NO2 / Volume )            ; monod equation
  ]
  if Name = "reaction-12" or Name = "reaction-13" or Name = "reaction-16" or Name = "reaction-19" or Name = "reaction-20"
  [
    set MO ( item Pos C6H12O6  / Volume ) / ( item 4 C + item Pos C6H12O6 / Volume )            ; monod equation
  ]
  if Name = "reaction-14" or Name = "reaction-17"
  [
    set MO ( item Pos C2H5COO  / Volume ) / ( item 4 C + item Pos C2H5COO / Volume )            ; monod equation
  ]
  if Name = "reaction-15" or Name = "reaction-18"
  [
    set MO ( item Pos CH3COO  / Volume ) / ( item 4 C + item Pos CH3COO / Volume )            ; monod equation
  ]
  if Name = "reaction-21"
  [
    set MO ( item Pos SO32  / Volume ) / ( item 4 C + item Pos SO32 / Volume )            ; monod equation
  ]
  if Name = "reaction-22"
  [
    set MO ( item Pos S2O32  / Volume ) / ( item 4 C + item Pos S2O32 / Volume )            ; monod equation
  ]


  if Name =  "reaction-12" or Name = "reaction-13" or Name = "reaction-16" or Name = "reaction-19" or Name = "reaction-20"; set substrate
  [
    set subs replace-item 0 subs item 7 C
  ]
  if Name = "reaction-14" or Name = "reaction-17"; set substrate
  [
    set subs replace-item 1 subs item 8 C
  ]
  if Name = "reaction-15" or Name = "reaction-18" ; set substrate
  [
    set subs replace-item 2 subs item 9 C
  ]
  if Name = "reaction-5" or Name = "reaction-6" or Name = "reaction-7" or Name = "reaction-8"   ; ;; set substrate
  [
    set subs replace-item 2 subs -0.125
  ]
  if Name = "reaction-1" or Name = "reaction-2" or Name = "reaction-3" or Name = "reaction-4" or Name = "reaction-9" or Name = "reaction-10" or Name = "reaction-11" or Name = "reaction-21" or Name = "reaction-22"  ; set substrate
  [
    set subs replace-item 3 subs -0.25
  ]

  if item 5 C = 20 ; set nitrogen source
  [
       set subs replace-item 4 subs (- 1 / 20)
  ]
  if item 5 C = 28 ; set nitrogen source
  [
       set subs replace-item 5 subs  (- 1 / 28)
  ]
  if item 5 C = 26 ; set nitrogen source
  [
       set subs replace-item 6 subs (- 1 / 26)
  ]
  if item 5 C = 23 ; set nitrogen source
  [
       set subs replace-item 7 subs (- 1 / 46)
  ]

  set MO MO * MassTransferEfficiency
  ;If fuction here is to avoid calculation error
  if item 0 tdd < 0 and item Pos C6H12O6 > ( -  ( item 7 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 0 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))) and item Pos C2H5COO > ( - ( item 8 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 1 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))) and item Pos CH3COO > ( -  ( item 9 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 2 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))) and item Pos Fe2 > ( -  item 10 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time)) and item Pos Fe3 > ( -  item 11 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time)) and item Pos Mn2 > ( -  item 12 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time)) and item Pos MnO2 > ( -  item 13 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time)) and item Pos NH3 > ( - (item 14 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 4 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))) and item Pos NO2 > ( - (item 15 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 6 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))) and item Pos NO3 > ( -  (item 16 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 5 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))) and item Pos HS > ( -  item 17 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time)) and item Pos S2O32 > ( -  item 18 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time)) and item Pos SO42 > ( -  item 19 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time)) and item Pos SO32 > ( -  item 20 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time)) and item Pos O2 > ( - (item 21 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 21 C * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))) and item Pos N2 > ( - (item 22 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 7 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))) and item Pos CO2 > ( -  (item 23 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 3 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time)) )
   [
    set C6H12O6 replace-item Pos C6H12O6 (item Pos C6H12O6 + ( item 7 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 0 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time)))
    set C2H5COO replace-item Pos C2H5COO (item Pos C2H5COO + ( item 8 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 1 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time)))
    set CH3COO replace-item Pos CH3COO (item Pos CH3COO + ( item 9 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 2 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time)))
    set Fe2 replace-item Pos Fe2 (item Pos Fe2 + item 10 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time))
    set Fe3 replace-item Pos Fe3 (item Pos Fe3 + item 11 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time))
    set Mn2 replace-item Pos Mn2 (item Pos Mn2 + item 12 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time))
    set MnO2 replace-item Pos MnO2 (item Pos MnO2 + item 13 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time))
    set NH3 replace-item Pos NH3 (item Pos NH3 + item 14 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 4 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))
    set NO2 replace-item Pos NO2 (item Pos NO2 + item 15 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 6 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))
    set NO3 replace-item Pos NO3 (item Pos NO3 + item 16 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 5 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))
    set HS replace-item Pos HS (item Pos HS + item 17 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time))
    set S2O32 replace-item Pos S2O32 (item Pos S2O32 + item 18 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time))
    set SO42 replace-item Pos SO42 (item Pos SO42 + item 19 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time))
    set SO32 replace-item Pos SO32 (item Pos SO32 + item 20 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time))
    set O2 replace-item Pos O2 (item Pos O2 + item 21 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 21 C * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))
    set N2 replace-item Pos N2 (item Pos N2 + item 22 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 7 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))
    set CO2 replace-item Pos CO2 (item Pos CO2 + item 23 C * Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) + item 3 subs * Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time))
    set CellWeight CellWeight * e ^ ( item 5 tdd * MO / (60 / Step_Time)) ;;cell growth
    set EEG EEG + Cellweight * item 4 tdd * MO * item 1 tdd / (60 / Step_Time) ;;;record the electron for energy generation
    set ECS ECS + Cellweight * item 4 tdd * MO * item 2 tdd / (60 / Step_Time)  ;;;record the  electron for cell synthesis
  ]
  if item Pos O2 > (CellWeight - (CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)))) * 96 / 452 / 32
  [
    set CH3COO replace-item Pos CH3COO (item Pos CH3COO + (CellWeight - (CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)))) * 472 / 452 / 59)
    set O2 replace-item Pos O2 (item Pos O2 - (CellWeight - (CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)))) * 96 / 452 / 32)
    set NH3 replace-item Pos NH3 (item Pos NH3 + (CellWeight - (CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)))) * 68 / 452 / 17)
    set CO2 replace-item Pos CO2 (item Pos CO2 + (CellWeight - (CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)))) * 176 / 452 / 44)
    set CellWeight CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)) ;decay
  ]
  if item Pos O2 <= (CellWeight - (CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)))) * 96 / 452 / 32
  [
    set CH3COO replace-item Pos CH3COO (item Pos CH3COO + (CellWeight - (CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)))) * 295 / 226 / 59)
    set NH3 replace-item Pos NH3 (item Pos NH3 + (CellWeight - (CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)))) * 34 / 226 / 17)
    set CellWeight CellWeight * e ^ ( - item 6 C / 24 / (60 / Step_Time)) ;decay
  ]
end

to flow
  set i 4
  while [i > 0]
  [
    set C6H12O6 replace-item i C6H12O6 (item i C6H12O6 - (H_L / (60 / Step_Time)) / unit_hight * (item i C6H12O6 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) C6H12O6 ))
    set C2H5COO replace-item i C2H5COO (item i C2H5COO - (H_L / (60 / Step_Time)) / unit_hight * (item i C2H5COO ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) C2H5COO ))
    set CH3COO replace-item i CH3COO (item i CH3COO - (H_L / (60 / Step_Time)) / unit_hight * (item i CH3COO ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) CH3COO ))
    set Fe2 replace-item i Fe2 (item i Fe2 - (H_L / (60 / Step_Time)) / unit_hight * (item i Fe2 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) Fe2 ))
    set Fe3 replace-item i Fe3 (item i Fe3 - (H_L / (60 / Step_Time)) / unit_hight * (item i Fe3 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) Fe3 ))
    set Mn2 replace-item i Mn2 (item i Mn2 - (H_L / (60 / Step_Time)) / unit_hight * (item i Mn2 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) Mn2 ))
    set MnO2 replace-item i MnO2 (item i MnO2 - (H_L / (60 / Step_Time)) / unit_hight * (item i MnO2 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) MnO2 ))
    set NH3 replace-item i NH3 (item i NH3 - (H_L / (60 / Step_Time)) / unit_hight * (item i NH3 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) NH3 ))
    set NO2 replace-item i NO2 (item i NO2 - (H_L / (60 / Step_Time)) / unit_hight * (item i NO2 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) NO2 ))
    set NO3 replace-item i NO3 (item i NO3 - (H_L / (60 / Step_Time)) / unit_hight * (item i NO3 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) NO3 ))
    set HS replace-item i HS (item i HS - (H_L / (60 / Step_Time)) / unit_hight * (item i HS ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) HS ))
    set S2O32 replace-item i S2O32 (item i S2O32 - (H_L / (60 / Step_Time)) / unit_hight * (item i S2O32 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) S2O32 ))
    set SO42 replace-item i SO42 (item i SO42 - (H_L / (60 / Step_Time)) / unit_hight * (item i SO42 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) SO42 ))
    set SO32 replace-item i SO32 (item i SO32 - (H_L / (60 / Step_Time)) / unit_hight * (item i SO32 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) SO32 ))
    set O2 replace-item i O2 (item i O2 - (H_L / (60 / Step_Time)) / unit_hight * (item i O2 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) O2 ))
    set N2 replace-item i N2 (item i N2 - (H_L / (60 / Step_Time)) / unit_hight * (item i N2 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) N2 ))
    set CO2 replace-item i CO2 (item i CO2 - (H_L / (60 / Step_Time)) / unit_hight * (item i CO2 ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) CO2 ))
    set hh replace-item i hh (item i hh - (H_L / (60 / Step_Time)) / unit_hight * (item i hh ) + (H_L / (60 / Step_Time)) / unit_hight * (item (i - 1) hh ))
    set i i - 1
  ]
  set C6H12O6 replace-item i C6H12O6 (item i C6H12O6 - (H_L / (60 / Step_Time)) / unit_hight * (item i C6H12O6 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-Glucose * Volume  + 0.0000001))
  set C2H5COO replace-item i C2H5COO (item i C2H5COO - (H_L / (60 / Step_Time)) / unit_hight * (item i C2H5COO ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-Propionate * Volume  + 0.0000001))
  set CH3COO replace-item i CH3COO (item i CH3COO - (H_L / (60 / Step_Time)) / unit_hight * (item i CH3COO ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-Acetate * Volume  + 0.0000001))
  set Fe2 replace-item i Fe2 (item i Fe2 - (H_L / (60 / Step_Time)) / unit_hight * (item i Fe2 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-Fe2 * Volume  + 0.0000001))
  set Fe3 replace-item i Fe3 (item i Fe3 - (H_L / (60 / Step_Time)) / unit_hight * (item i Fe3 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-Fe3 * Volume  + 0.0000001))
  set Mn2 replace-item i Mn2 (item i Mn2 - (H_L / (60 / Step_Time)) / unit_hight * (item i Mn2 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-Mn2 * Volume  + 0.0000001))
  set MnO2 replace-item i MnO2 (item i MnO2 - (H_L / (60 / Step_Time)) / unit_hight * (item i MnO2 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-MnO2 * Volume  + 0.0000001))
  set NH3 replace-item i NH3 (item i NH3 - (H_L / (60 / Step_Time)) / unit_hight * (item i NH3 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-NH3 * Volume  + 0.0000001))
  set NO2 replace-item i NO2 (item i NO2 - (H_L / (60 / Step_Time)) / unit_hight * (item i NO2 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-NO2 * Volume  + 0.0000001))
  set NO3 replace-item i NO3 (item i NO3 - (H_L / (60 / Step_Time)) / unit_hight * (item i NO3 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-NO3 * Volume  + 0.0000001))
  set HS replace-item i HS (item i HS - (H_L / (60 / Step_Time)) / unit_hight * (item i HS ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-HS * Volume ))
  set S2O32 replace-item i S2O32 (item i S2O32 - (H_L / (60 / Step_Time)) / unit_hight * (item i S2O32 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-S2O3 * Volume  + 0.0000001))
  set SO42 replace-item i SO42 (item i SO42 - (H_L / (60 / Step_Time)) / unit_hight * (item i SO42 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-SO4 * Volume  + 0.0000001))
  set SO32 replace-item i SO32 (item i SO32 - (H_L / (60 / Step_Time)) / unit_hight * (item i SO32 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-SO3 * Volume  + 0.0000001))
  set O2 replace-item i O2 (item i O2 - (H_L / (60 / Step_Time)) / unit_hight * (item i O2 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-O2 * Volume + 0.0000001 ))
  set N2 replace-item i N2 (item i N2 - (H_L / (60 / Step_Time)) / unit_hight * (item i N2 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-N2 * Volume + 0.0000001 ))
  set CO2 replace-item i CO2 (item i CO2 - (H_L / (60 / Step_Time)) / unit_hight * (item i CO2 ) + (H_L / (60 / Step_Time)) / unit_hight * (Initial-CO2 * Volume + 0.0000001 ))
end

to move  ;; turtle move
  rt random 180
  fd random (Step_Time + 1)
end

to reproduce  ;; turtle procedure
  if Cellweight >= 5 * InitialCellweight
  [
    set Cellweight Cellweight / 2
	  set EEG EEG / 2
	  set ECS ECS / 2
    hatch 1
    [
      rt random 180
      fd random Step_Time * 5
    ]
  ]
end

to combine  ;; turtle procedure
            ; take one turtle from the same patch as a target
            ; which has turtles-inside low enough to combine with
  let target one-of other breed with
    [Name = [Name] of myself and Pos = [Pos] of myself and Cellweight <= InitialCellweight / 5 ]
  if target != nobody
  [
    set Cellweight Cellweight + [Cellweight] of target            ;; increase Cellweight
    set EEG (EEG + [EEG] of target)
    set ECS (ECS + [ECS] of target)
    ask target [ die ]                      ;; kill the target
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
550
50
619
1058
-1
-1
1.0
1
10
1
1
1
0
1
0
1
-30
30
-499
499
0
0
0
min
30.0

BUTTON
85
15
155
48
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
15
15
85
78
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
85
45
155
78
One step
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
155
15
225
78
StopTime
30320.0
1
0
Number

SLIDER
230
255
420
288
InitialCellweight
InitialCellweight
0.005
5
1.0
0.005
1
mg
HORIZONTAL

INPUTBOX
275
165
430
225
MassTransferEfficiency
0.5
1
0
Number

INPUTBOX
275
105
430
165
EnergyTransferEfficiency
0.65
1
0
Number

SLIDER
275
15
430
48
pH
pH
1
14
6.8
0.1
1
NIL
HORIZONTAL

SLIDER
275
45
430
78
Temperature
Temperature
20
60
25.0
1
1
℃
HORIZONTAL

INPUTBOX
230
325
330
385
Initial-Fe2
0.0
1
0
Number

INPUTBOX
230
385
330
445
Initial-Fe3
0.0
1
0
Number

INPUTBOX
230
445
330
505
Initial-Mn2
0.0
1
0
Number

INPUTBOX
230
505
330
565
Initial-MnO2
0.0
1
0
Number

INPUTBOX
230
565
330
625
Initial-NH3
0.0
1
0
Number

INPUTBOX
230
685
330
745
Initial-NO2
0.0
1
0
Number

INPUTBOX
230
625
330
685
Initial-NO3
0.0
1
0
Number

INPUTBOX
230
745
330
805
Initial-N2
0.0
1
0
Number

INPUTBOX
230
805
330
865
Initial-CO2
0.0
1
0
Number

INPUTBOX
330
325
430
385
Initial-Glucose
0.0
1
0
Number

INPUTBOX
330
385
430
445
Initial-Acetate
0.0
1
0
Number

INPUTBOX
330
445
430
505
Initial-Propionate
0.0
1
0
Number

INPUTBOX
330
505
430
565
Initial-SO4
0.0
1
0
Number

INPUTBOX
330
565
430
625
Initial-S2O3
0.0
1
0
Number

INPUTBOX
330
625
430
685
Initial-SO3
0.0
1
0
Number

INPUTBOX
330
685
430
745
Initial-S
0.0
1
0
Number

INPUTBOX
330
745
430
805
Initial-HS
0.0
1
0
Number

INPUTBOX
330
805
430
865
Initial-O2
0.0
1
0
Number

SLIDER
15
200
205
233
initial-reaction-1
initial-reaction-1
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
230
205
263
initial-reaction-2
initial-reaction-2
0
100
8.0
1
1
mg/L
HORIZONTAL

SLIDER
15
260
205
293
initial-reaction-3
initial-reaction-3
0
100
8.0
1
1
mg/L
HORIZONTAL

SLIDER
15
290
205
323
initial-reaction-4
initial-reaction-4
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
320
205
353
initial-reaction-5
initial-reaction-5
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
350
205
383
initial-reaction-6
initial-reaction-6
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
380
205
413
initial-reaction-7
initial-reaction-7
0
100
8.0
1
1
mg/L
HORIZONTAL

SLIDER
15
410
205
443
initial-reaction-8
initial-reaction-8
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
440
205
473
initial-reaction-9
initial-reaction-9
0
100
8.0
1
1
mg/L
HORIZONTAL

SLIDER
15
470
205
503
initial-reaction-10
initial-reaction-10
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
500
205
533
initial-reaction-11
initial-reaction-11
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
530
205
563
initial-reaction-12
initial-reaction-12
0
100
8.0
1
1
mg/L
HORIZONTAL

SLIDER
15
560
205
593
initial-reaction-13
initial-reaction-13
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
590
205
623
initial-reaction-14
initial-reaction-14
0
100
8.0
1
1
mg/L
HORIZONTAL

SLIDER
15
620
205
653
initial-reaction-15
initial-reaction-15
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
650
205
683
initial-reaction-16
initial-reaction-16
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
680
205
713
initial-reaction-17
initial-reaction-17
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
710
205
743
initial-reaction-18
initial-reaction-18
0
100
7.0
1
1
mg/L
HORIZONTAL

SLIDER
15
740
205
773
initial-reaction-19
initial-reaction-19
0
100
6.0
1
1
mg/L
HORIZONTAL

SLIDER
15
770
205
803
initial-reaction-20
initial-reaction-20
0
100
5.0
1
1
mg/L
HORIZONTAL

SLIDER
15
800
205
833
initial-reaction-21
initial-reaction-21
0
100
9.0
1
1
mg/L
HORIZONTAL

SLIDER
15
830
205
863
initial-reaction-22
initial-reaction-22
0
100
8.0
1
1
mg/L
HORIZONTAL

PLOT
15
870
235
1100
Total Microorganisms - depth
Time
Dry cell Weight (mg/L)
0.0
400.0
0.0
5.001
true
false
"" ""
PENS
"0-20 cm" 1.0 0 -2674135 true "" "plotxy time  (sum [Cellweight] of Microbes with [Pos = 0]) / Volume"
"20-40 cm cm" 1.0 0 -4079321 true "" "plotxy time  (sum [Cellweight] of Microbes with [Pos = 1]) / Volume"
"40-60 cm" 1.0 0 -13791810 true "" "plotxy time  (sum [Cellweight] of Microbes with [Pos = 2]) / Volume"
"60-80 cm" 1.0 0 -11085214 true "" "plotxy time  (sum [Cellweight] of Microbes with [Pos = 3]) / Volume"
"80-100 cm" 1.0 0 -3508570 true "" "plotxy time  (sum [Cellweight] of Microbes with [Pos = 4]) / Volume"

PLOT
235
870
495
1100
COD
Time (min)
COD (mg/L)
0.0
400.0
0.0
10.0
true
true
"" ""
PENS
"0-20 cm" 1.0 0 -2674135 true "" "plotxy time  item 0 COD"
"20-40 cm cm" 1.0 0 -4079321 true "" "plotxy time  item 1 COD"
"40-60 cm" 1.0 0 -13791810 true "" "plotxy time  item 2 COD"
"60-80 cm" 1.0 0 -11085214 true "" "plotxy time  item 3 COD"
"80-100 cm" 1.0 0 -3508570 true "" "plotxy time  item 4 COD"

TEXTBOX
235
310
440
333
Substrate concentration of influent (mmol/L)
10
0.0
1

TEXTBOX
15
185
220
203
Cell weight at initial stage
12
0.0
1

TEXTBOX
228
225
458
256
Agent size at initial stage\n(for the precision of simulation )
10
0.0
1

TEXTBOX
20
1140
466
1225
Developed by Zhuang Huichuan & Liang Qing\nThe Hong Kong Polytechnic University
20
6.0
1

PLOT
1000
10
1180
210
Substrate-carbon(0-20 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" C6H12O6 " 1.0 0 -955883 true "" "plotxy time  item 0 C6H12O6 / Volume"
" C2H5COO " 1.0 0 -6459832 true "" "plotxy time  item 0 C2H5COO / Volume"
" CH3COO " 1.0 0 -1184463 true "" "plotxy time  item 0 CH3COO / Volume"
" O2 " 1.0 0 -10899396 true "" "plotxy time  item 0 O2 / Volume"
" CO2 " 1.0 0 -5298144 true "" "plotxy time  item 0 CO2 / Volume"

PLOT
1180
10
1360
210
Substrate-sulfur(0-20 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" SO42 " 1.0 0 -955883 true "" "plotxy time  item 0 SO42 / Volume"
" SO32 " 1.0 0 -6459832 true "" "plotxy time  item 0 SO32 / Volume"
" S2O32 " 1.0 0 -1184463 true "" "plotxy time  item 0 S2O32 / Volume"
" HS " 1.0 0 -10899396 true "" "plotxy time  item 0 HS / Volume"

PLOT
640
10
820
210
Substrate-metal(0-20 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" Fe2 " 1.0 0 -955883 true "" "plotxy time  item 0 Fe2 / Volume"
" Fe3 " 1.0 0 -6459832 true "" "plotxy time  item 0 Fe3 / Volume"
" Mn2 " 1.0 0 -1184463 true "" "plotxy time  item 0 Mn2 / Volume"
" MnO2 " 1.0 0 -10899396 true "" "plotxy time  item 0 MnO2 / Volume"

PLOT
820
10
1000
210
Substrate-nitrogen(0-20 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" NH3 " 1.0 0 -955883 true "" "plotxy time  item 0 NH3 / Volume"
" NO2 " 1.0 0 -6459832 true "" "plotxy time  item 0 NO2 / Volume"
" NO3 " 1.0 0 -1184463 true "" "plotxy time  item 0 NO3 / Volume"
" N2 " 1.0 0 -10899396 true "" "plotxy time  item 0 N2 / Volume"

PLOT
1360
10
1540
210
Gibbs free energy(0-20 cm)
Time (min)
Gibbs free energy (kJ/mEq)
0.0
400.0
-50.0
5.0
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-1\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 0]) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-2\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 0]) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-3\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 0]) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-4\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 0]) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-5\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 0]) "
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-6\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 0]) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-7\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 0]) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-8\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 0]) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-9\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 0]) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-10\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 0]) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-11\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 0]) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-12\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 0])"
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-13\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 0])"
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-14\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 0])"
"Reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-15\" and Pos = 0])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 0])"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 0])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 0])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 0])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 0])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 0])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 0])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 0])"
"0" 1.0 0 -16777216 true "" "plotxy time  0"

PLOT
1895
10
2055
210
Activated Microorganisms(0-20 cm)
Time
Dry Cell Weight (mg/L)
0.0
400.0
0.0
5.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-1\" and Pos = 0]) / Volume"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-2\" and Pos = 0]) / Volume"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-3\" and Pos = 0]) / Volume"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-4\" and Pos = 0]) / Volume"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-5\" and Pos = 0]) / Volume"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-6\" and Pos = 0]) / Volume"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-7\" and Pos = 0]) / Volume"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-8\" and Pos = 0]) / Volume"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-9\" and Pos = 0]) / Volume"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-10\" and Pos = 0]) / Volume"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-11\" and Pos = 0]) / Volume"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-12\" and Pos = 0]) / Volume"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-13\" and Pos = 0]) / Volume"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-14\" and Pos = 0]) / Volume"
"reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-15\" and Pos = 0]) / Volume"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-16\" and Pos = 0]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-17\" and Pos = 0]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-18\" and Pos = 0]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-19\" and Pos = 0]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-20\" and Pos = 0]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-21\" and Pos = 0]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-22\" and Pos = 0]) / Volume"

PLOT
1540
10
1720
210
Electron for energy generation (0-20 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-1\" and pos = 0] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-2\" and pos = 0] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-3\" and pos = 0] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-4\" and pos = 0] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-5\" and pos = 0] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-6\" and pos = 0] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-7\" and pos = 0] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-8\" and pos = 0] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-9\" and pos = 0] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-10\" and pos = 0] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-11\" and pos = 0] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-12\" and pos = 0] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-13\" and pos = 0] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-14\" and pos = 0] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-15\" and pos = 0] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-16\" and Pos = 0]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-17\" and Pos = 0]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-18\" and Pos = 0]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-19\" and Pos = 0]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-20\" and Pos = 0]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-21\" and Pos = 0]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-22\" and Pos = 0]) / Volume"

PLOT
1715
10
1895
210
Electron for cell synthesis (0-20 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-1\" and pos = 0] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-2\" and pos = 0] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-3\" and pos = 0] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-4\" and pos = 0] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-5\" and pos = 0] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-6\" and pos = 0] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-7\" and pos = 0] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-8\" and pos = 0] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-9\" and pos = 0] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-10\" and pos = 0] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-11\" and pos = 0] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-12\" and pos = 0] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-13\" and pos = 0] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-14\" and pos = 0] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-15\" and pos = 0] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-16\" and Pos = 0]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-17\" and Pos = 0]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-18\" and Pos = 0]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-19\" and Pos = 0]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-20\" and Pos = 0]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-21\" and Pos = 0]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-22\" and Pos = 0]) / Volume"

PLOT
2055
10
2215
210
E (0-20 cm)
Time (min)
E (mEq/L·h·gcell)
0.0
10.0
0.0
0.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-1\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 0] )"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-2\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 0] )"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-3\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 0] )"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-4\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 0] )"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-5\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 0] )"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-6\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 0] )"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-7\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 0] )"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-8\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 0] )"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-9\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 0] )"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-10\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 0] )"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-11\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 0] )"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-12\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 0] )"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-13\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 0] )"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-14\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 0] )"
"reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-15\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 0] )"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 0])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 0])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 0])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 0])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 0])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 0])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 0]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 0])"

PLOT
1000
210
1180
410
Substrate-carbon(20-40 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" C6H12O6 " 1.0 0 -955883 true "" "plotxy time  item 1 C6H12O6 / Volume"
" C2H5COO " 1.0 0 -6459832 true "" "plotxy time  item 1 C2H5COO / Volume"
" CH3COO " 1.0 0 -1184463 true "" "plotxy time  item 1 CH3COO / Volume"
" O2 " 1.0 0 -10899396 true "" "plotxy time  item 1 O2 / Volume"
" CO2 " 1.0 0 -5298144 true "" "plotxy time  item 1 CO2 / Volume"

PLOT
1180
210
1360
410
Substrate-sulfur(20-40 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" SO42 " 1.0 0 -955883 true "" "plotxy time  item 1 SO42 / Volume"
" SO32 " 1.0 0 -6459832 true "" "plotxy time  item 1 SO32 / Volume"
" S2O32 " 1.0 0 -1184463 true "" "plotxy time  item 1 S2O32 / Volume"
" HS " 1.0 0 -10899396 true "" "plotxy time  item 1 HS / Volume"

PLOT
640
210
820
410
Substrate-metal(20-40 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" Fe2 " 1.0 0 -955883 true "" "plotxy time  item 1 Fe2 / Volume"
" Fe3 " 1.0 0 -6459832 true "" "plotxy time  item 1 Fe3 / Volume"
" Mn2 " 1.0 0 -1184463 true "" "plotxy time  item 1 Mn2 / Volume"
" MnO2 " 1.0 0 -10899396 true "" "plotxy time  item 1 MnO2 / Volume"

PLOT
820
210
1000
410
Substrate-nitrogen(20-40 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" NH3 " 1.0 0 -955883 true "" "plotxy time  item 1 NH3 / Volume"
" NO2 " 1.0 0 -6459832 true "" "plotxy time  item 1 NO2 / Volume"
" NO3 " 1.0 0 -1184463 true "" "plotxy time  item 1 NO3 / Volume"
" N2 " 1.0 0 -10899396 true "" "plotxy time  item 1 N2 / Volume"

PLOT
1360
210
1540
410
Gibbs free energy(20-40 cm)
Time (min)
Gibbs free energy (kJ/mEq)
0.0
400.0
-50.0
5.0
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-1\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 1]) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-2\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 1]) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-3\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 1]) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-4\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 1]) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-5\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 1]) "
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-6\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 1]) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-7\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 1]) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-8\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 1]) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-9\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 1]) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-10\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 1]) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-11\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 1]) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-12\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 1])"
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-13\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 1])"
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-14\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 1])"
"Reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-15\" and Pos = 1])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 1])"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 1])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 1])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 1] + 0.0000000000001)"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 1])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 1])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 1])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 1])"
"0" 1.0 0 -16777216 true "" "plotxy time  0"

PLOT
1895
210
2055
410
Activated Microorganisms(20-40 cm)
Time
Dry Cell Weight (mg/L)
0.0
400.0
0.0
5.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-1\" and Pos = 1]) / Volume"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-2\" and Pos = 1]) / Volume"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-3\" and Pos = 1]) / Volume"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-4\" and Pos = 1]) / Volume"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-5\" and Pos = 1]) / Volume"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-6\" and Pos = 1]) / Volume"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-7\" and Pos = 1]) / Volume"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-8\" and Pos = 1]) / Volume"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-9\" and Pos = 1]) / Volume"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-10\" and Pos = 1]) / Volume"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-11\" and Pos = 1]) / Volume"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-12\" and Pos = 1]) / Volume"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-13\" and Pos = 1]) / Volume"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-14\" and Pos = 1]) / Volume"
"reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-15\" and Pos = 1]) / Volume"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-16\" and Pos = 1]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-17\" and Pos = 1]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-18\" and Pos = 1]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-19\" and Pos = 1]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-20\" and Pos = 1]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-21\" and Pos = 1]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-22\" and Pos = 1]) / Volume"

PLOT
1540
210
1720
410
Electron for energy generation (20-40 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-1\" and Pos = 1] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-2\" and Pos = 1] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-3\" and Pos = 1] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-4\" and Pos = 1] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-5\" and Pos = 1] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-6\" and Pos = 1] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-7\" and Pos = 1] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-8\" and Pos = 1] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-9\" and Pos = 1] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-10\" and Pos = 1] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-11\" and Pos = 1] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-12\" and Pos = 1] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-13\" and Pos = 1] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-14\" and Pos = 1] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-15\" and Pos = 1] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-16\" and Pos = 1]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-17\" and Pos = 1]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-18\" and Pos = 1]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-19\" and Pos = 1]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-20\" and Pos = 1]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-21\" and Pos = 1]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-22\" and Pos = 1]) / Volume"

PLOT
1715
210
1895
410
Electron for cell synthesis (20-40 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-1\" and Pos = 1] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-2\" and Pos = 1] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-3\" and Pos = 1] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-4\" and Pos = 1] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-5\" and Pos = 1] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-6\" and Pos = 1] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-7\" and Pos = 1] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-8\" and Pos = 1] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-9\" and Pos = 1] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-10\" and Pos = 1] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-11\" and Pos = 1] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-12\" and Pos = 1] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-13\" and Pos = 1] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-14\" and Pos = 1] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-15\" and Pos = 1] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-16\" and Pos = 1]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-17\" and Pos = 1]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-18\" and Pos = 1]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-19\" and Pos = 1]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-20\" and Pos = 1]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-21\" and Pos = 1]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-22\" and Pos = 1]) / Volume"

PLOT
2055
210
2215
410
E (20-40 cm)
Time (min)
E (mEq/L·h·gcell)
0.0
10.0
0.0
0.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-1\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 1] )"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-2\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 1] )"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-3\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 1] )"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-4\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 1] )"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-5\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 1] )"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-6\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 1] )"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-7\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 1] )"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-8\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 1] )"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-9\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 1] )"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-10\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 1] )"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-11\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 1] )"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-12\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 1] )"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-13\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 1] )"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-14\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 1] )"
"reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-15\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 1] )"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 1])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 1])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 1])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 1])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 1])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 1])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 1]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 1])"

PLOT
1000
410
1180
610
Substrate-carbon(40-60 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" C6H12O6 " 1.0 0 -955883 true "" "plotxy time  item 2 C6H12O6 / Volume"
" C2H5COO " 1.0 0 -6459832 true "" "plotxy time  item 2 C2H5COO / Volume"
" CH3COO " 1.0 0 -1184463 true "" "plotxy time  item 2 CH3COO / Volume"
" O2 " 1.0 0 -10899396 true "" "plotxy time  item 2 O2 / Volume"
" CO2 " 1.0 0 -5298144 true "" "plotxy time  item 2 CO2 / Volume"

PLOT
1180
410
1360
610
Substrate-sulfur(40-60 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" SO42 " 1.0 0 -955883 true "" "plotxy time  item 2 SO42 / Volume"
" SO32 " 1.0 0 -6459832 true "" "plotxy time  item 2 SO32 / Volume"
" S2O32 " 1.0 0 -1184463 true "" "plotxy time  item 2 S2O32 / Volume"
" HS " 1.0 0 -10899396 true "" "plotxy time  item 2 HS / Volume"

PLOT
640
410
820
610
Substrate-metal(40-60 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" Fe2 " 1.0 0 -955883 true "" "plotxy time  item 2 Fe2 / Volume"
" Fe3 " 1.0 0 -6459832 true "" "plotxy time  item 2 Fe3 / Volume"
" Mn2 " 1.0 0 -1184463 true "" "plotxy time  item 2 Mn2 / Volume"
" MnO2 " 1.0 0 -10899396 true "" "plotxy time  item 2 MnO2 / Volume"

PLOT
820
410
1000
610
Substrate-nitrogen(40-60 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" NH3 " 1.0 0 -955883 true "" "plotxy time  item 2 NH3 / Volume"
" NO2 " 1.0 0 -6459832 true "" "plotxy time  item 2 NO2 / Volume"
" NO3 " 1.0 0 -1184463 true "" "plotxy time  item 2 NO3 / Volume"
" N2 " 1.0 0 -10899396 true "" "plotxy time  item 2 N2 / Volume"

PLOT
1360
410
1540
610
Gibbs free energy(40-60 cm)
Time (min)
Gibbs free energy (kJ/mEq)
0.0
400.0
-50.0
5.0
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-1\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 2]) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-2\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 2]) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-3\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 2]) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-4\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 2]) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-5\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 2]) "
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-6\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 2]) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-7\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 2]) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-8\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 2]) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-9\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 2]) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-10\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 2]) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-11\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 2]) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-12\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 2])"
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-13\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 2])"
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-14\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 2])"
"Reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-15\" and Pos = 2])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 2])"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 2])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 2])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 2]) / ( 0.000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 2])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 2])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 2])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 2])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 2])"
"0" 1.0 0 -16777216 true "" "plotxy time  0"

PLOT
1895
410
2055
610
Activated Microorganisms(40-60 cm)
Time
Dry Cell Weight (mg/L)
0.0
400.0
0.0
5.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-1\" and Pos = 2]) / Volume"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-2\" and Pos = 2]) / Volume"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-3\" and Pos = 2]) / Volume"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-4\" and Pos = 2]) / Volume"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-5\" and Pos = 2]) / Volume"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-6\" and Pos = 2]) / Volume"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-7\" and Pos = 2]) / Volume"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-8\" and Pos = 2]) / Volume"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-9\" and Pos = 2]) / Volume"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-10\" and Pos = 2]) / Volume"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-11\" and Pos = 2]) / Volume"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-12\" and Pos = 2]) / Volume"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-13\" and Pos = 2]) / Volume"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-14\" and Pos = 2]) / Volume"
"reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-15\" and Pos = 2]) / Volume"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-16\" and Pos = 2]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-17\" and Pos = 2]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-18\" and Pos = 2]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-19\" and Pos = 2]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-20\" and Pos = 2]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-21\" and Pos = 2]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-22\" and Pos = 2]) / Volume"

PLOT
1540
410
1720
610
Electron for energy generation (40-60 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-1\" and Pos = 2] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-2\" and Pos = 2] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-3\" and Pos = 2] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-4\" and Pos = 2] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-5\" and Pos = 2] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-6\" and Pos = 2] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-7\" and Pos = 2] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-8\" and Pos = 2] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-9\" and Pos = 2] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-10\" and Pos = 2] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-11\" and Pos = 2] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-12\" and Pos = 2] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-13\" and Pos = 2] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-14\" and Pos = 2] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-15\" and Pos = 2] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-16\" and Pos = 2]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-17\" and Pos = 2]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-18\" and Pos = 2]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-19\" and Pos = 2]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-20\" and Pos = 2]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-21\" and Pos = 2]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-22\" and Pos = 2]) / Volume"

PLOT
1715
410
1895
610
Electron for cell synthesis (40-60 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-1\" and Pos = 2] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-2\" and Pos = 2] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-3\" and Pos = 2] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-4\" and Pos = 2] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-5\" and Pos = 2] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-6\" and Pos = 2] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-7\" and Pos = 2] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-8\" and Pos = 2] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-9\" and Pos = 2] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-10\" and Pos = 2] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-11\" and Pos = 2] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-12\" and Pos = 2] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-13\" and Pos = 2] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-14\" and Pos = 2] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-15\" and Pos = 2] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-16\" and Pos = 2]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-17\" and Pos = 2]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-18\" and Pos = 2]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-19\" and Pos = 2]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-20\" and Pos = 2]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-21\" and Pos = 2]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-22\" and Pos = 2]) / Volume"

PLOT
2055
410
2215
610
E (40-60 cm)
Time (min)
E (mEq/L·h·gcell)
0.0
10.0
0.0
0.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-1\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 2] )"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-2\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 2] )"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-3\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 2] )"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-4\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 2] )"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-5\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 2] )"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-6\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 2] )"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-7\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 2] )"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-8\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 2] )"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-9\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 2] )"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-10\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 2] )"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-11\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 2] )"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-12\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 2] )"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-13\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 2] )"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-14\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 2] )"
"reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-15\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 2] )"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 2])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 2])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 2])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 2])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 2])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 2])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 2]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 2])"

PLOT
1000
610
1180
810
Substrate-carbon(60-80 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" C6H12O6 " 1.0 0 -955883 true "" "plotxy time  item 3 C6H12O6 / Volume"
" C2H5COO " 1.0 0 -6459832 true "" "plotxy time  item 3 C2H5COO / Volume"
" CH3COO " 1.0 0 -1184463 true "" "plotxy time  item 3 CH3COO / Volume"
" O2 " 1.0 0 -10899396 true "" "plotxy time  item 3 O2 / Volume"
" CO2 " 1.0 0 -5298144 true "" "plotxy time  item 3 CO2 / Volume"

PLOT
1180
610
1360
810
Substrate-sulfur(60-80 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" SO42 " 1.0 0 -955883 true "" "plotxy time  item 3 SO42 / Volume"
" SO32 " 1.0 0 -6459832 true "" "plotxy time  item 3 SO32 / Volume"
" S2O32 " 1.0 0 -1184463 true "" "plotxy time  item 3 S2O32 / Volume"
" HS " 1.0 0 -10899396 true "" "plotxy time  item 3 HS / Volume"

PLOT
640
610
820
810
Substrate-metal(60-80 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" Fe2 " 1.0 0 -955883 true "" "plotxy time  item 3 Fe2 / Volume"
" Fe3 " 1.0 0 -6459832 true "" "plotxy time  item 3 Fe3 / Volume"
" Mn2 " 1.0 0 -1184463 true "" "plotxy time  item 3 Mn2 / Volume"
" MnO2 " 1.0 0 -10899396 true "" "plotxy time  item 3 MnO2 / Volume"

PLOT
820
610
1000
810
Substrate-nitrogen(60-80 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" NH3 " 1.0 0 -955883 true "" "plotxy time  item 3 NH3 / Volume"
" NO2 " 1.0 0 -6459832 true "" "plotxy time  item 3 NO2 / Volume"
" NO3 " 1.0 0 -1184463 true "" "plotxy time  item 3 NO3 / Volume"
" N2 " 1.0 0 -10899396 true "" "plotxy time  item 3 N2 / Volume"

PLOT
1360
610
1540
810
Gibbs free energy(60-80 cm)
Time (min)
Gibbs free energy (kJ/mEq)
0.0
400.0
-50.0
5.0
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-1\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 3]) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-2\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 3]) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-3\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 3]) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-4\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 3]) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-5\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 3]) "
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-6\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 3]) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-7\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 3]) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-8\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 3]) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-9\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 3]) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-10\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 3]) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-11\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 3]) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-12\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 3])"
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-13\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 3])"
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-14\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 3])"
"Reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-15\" and Pos = 3])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 3])"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 3])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 3])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 3])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 3])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 3])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 3])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 3])"
"0" 1.0 0 -16777216 true "" "plotxy time  0"

PLOT
1895
610
2055
810
Activated Microorganisms(60-80 cm)
Time
Dry Cell Weight (mg/L)
0.0
400.0
0.0
5.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-1\" and Pos = 3]) / Volume"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-2\" and Pos = 3]) / Volume"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-3\" and Pos = 3]) / Volume"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-4\" and Pos = 3]) / Volume"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-5\" and Pos = 3]) / Volume"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-6\" and Pos = 3]) / Volume"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-7\" and Pos = 3]) / Volume"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-8\" and Pos = 3]) / Volume"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-9\" and Pos = 3]) / Volume"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-10\" and Pos = 3]) / Volume"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-11\" and Pos = 3]) / Volume"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-12\" and Pos = 3]) / Volume"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-13\" and Pos = 3]) / Volume"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-14\" and Pos = 3]) / Volume"
"reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-15\" and Pos = 3]) / Volume"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-16\" and Pos = 3]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-17\" and Pos = 3]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-18\" and Pos = 3]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-19\" and Pos = 3]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-20\" and Pos = 3]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-21\" and Pos = 3]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-22\" and Pos = 3]) / Volume"

PLOT
1540
610
1720
810
Electron for energy generation (60-80 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-1\" and Pos = 3] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-2\" and Pos = 3] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-3\" and Pos = 3] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-4\" and Pos = 3] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-5\" and Pos = 3] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-6\" and Pos = 3] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-7\" and Pos = 3] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-8\" and Pos = 3] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-9\" and Pos = 3] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-10\" and Pos = 3] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-11\" and Pos = 3] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-12\" and Pos = 3] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-13\" and Pos = 3] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-14\" and Pos = 3] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-15\" and Pos = 3] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-16\" and Pos = 3]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-17\" and Pos = 3]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-18\" and Pos = 3]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-19\" and Pos = 3]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-20\" and Pos = 3]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-21\" and Pos = 3]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-22\" and Pos = 3]) / Volume"

PLOT
1715
610
1895
810
Electron for cell synthesis (60-80 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-1\" and Pos = 3] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-2\" and Pos = 3] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-3\" and Pos = 3] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-4\" and Pos = 3] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-5\" and Pos = 3] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-6\" and Pos = 3] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-7\" and Pos = 3] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-8\" and Pos = 3] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-9\" and Pos = 3] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-10\" and Pos = 3] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-11\" and Pos = 3] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-12\" and Pos = 3] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-13\" and Pos = 3] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-14\" and Pos = 3] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-15\" and Pos = 3] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-16\" and Pos = 3]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-17\" and Pos = 3]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-18\" and Pos = 3]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-19\" and Pos = 3]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-20\" and Pos = 3]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-21\" and Pos = 3]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-22\" and Pos = 3]) / Volume"

PLOT
2055
610
2215
810
E (60-80 cm)
Time (min)
E (mEq/L·h·gcell)
0.0
10.0
0.0
0.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-1\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 3] )"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-2\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 3] )"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-3\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 3] )"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-4\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 3] )"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-5\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 3] )"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-6\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 3] )"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-7\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 3] )"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-8\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 3] )"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-9\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 3] )"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-10\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 3] )"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-11\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 3] )"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-12\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 3] )"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-13\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 3] )"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-14\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 3] )"
"reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-15\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 3] )"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 3])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 3])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 3])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 3])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 3])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 3])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 3]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 3])"

PLOT
1000
810
1180
1010
Substrate-carbon(80-100 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" C6H12O6 " 1.0 0 -955883 true "" "plotxy time  item 4 C6H12O6 / Volume"
" C2H5COO " 1.0 0 -6459832 true "" "plotxy time  item 4 C2H5COO / Volume"
" CH3COO " 1.0 0 -1184463 true "" "plotxy time  item 4 CH3COO / Volume"
" O2 " 1.0 0 -10899396 true "" "plotxy time  item 4 O2 / Volume"
" CO2 " 1.0 0 -5298144 true "" "plotxy time  item 4 CO2 / Volume"

PLOT
1180
810
1360
1010
Substrate-sulfur(80-100 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" SO42 " 1.0 0 -955883 true "" "plotxy time  item 4 SO42 / Volume"
" SO32 " 1.0 0 -6459832 true "" "plotxy time  item 4 SO32 / Volume"
" S2O32 " 1.0 0 -1184463 true "" "plotxy time  item 4 S2O32 / Volume"
" HS " 1.0 0 -10899396 true "" "plotxy time  item 4 HS / Volume"

PLOT
640
810
820
1010
Substrate-metal(80-100 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" Fe2 " 1.0 0 -955883 true "" "plotxy time  item 4 Fe2 / Volume"
" Fe3 " 1.0 0 -6459832 true "" "plotxy time  item 4 Fe3 / Volume"
" Mn2 " 1.0 0 -1184463 true "" "plotxy time  item 4 Mn2 / Volume"
" MnO2 " 1.0 0 -10899396 true "" "plotxy time  item 4 MnO2 / Volume"

PLOT
820
810
1000
1010
Substrate-nitrogen(80-100 cm)
Time (min)
Concentration (mmol/L)
0.0
400.0
0.0
0.1
true
false
"" ""
PENS
" NH3 " 1.0 0 -955883 true "" "plotxy time  item 4 NH3 / Volume"
" NO2 " 1.0 0 -6459832 true "" "plotxy time  item 4 NO2 / Volume"
" NO3 " 1.0 0 -1184463 true "" "plotxy time  item 4 NO3 / Volume"
" N2 " 1.0 0 -10899396 true "" "plotxy time  item 4 N2 / Volume"

PLOT
1360
810
1540
1010
Gibbs free energy(80-100 cm)
Time (min)
Gibbs free energy (kJ/mEq)
0.0
400.0
-50.0
5.0
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-1\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 4]) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-2\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 4]) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-3\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 4]) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-4\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 4]) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-5\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 4]) "
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-6\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 4]) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-7\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 4]) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-8\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 4]) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-9\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 4]) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-10\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 4]) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-11\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 4]) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-12\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 4])"
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-13\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 4])"
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-14\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 4])"
"Reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 0 tdd] of Microbes with ([Name = \"reaction-15\" and Pos = 4])) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 4])"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 4])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 4])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 4])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 4])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 4])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 4])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 0 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 4])"
"0" 1.0 0 -16777216 true "" "plotxy time  0"

PLOT
1895
810
2055
1010
Activated Microorganisms(80-100 cm)
Time
Dry Cell Weight (mg/L)
0.0
400.0
0.0
5.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-1\" and Pos = 4]) / Volume"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-2\" and Pos = 4]) / Volume"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-3\" and Pos = 4]) / Volume"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-4\" and Pos = 4]) / Volume"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-5\" and Pos = 4]) / Volume"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-6\" and Pos = 4]) / Volume"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-7\" and Pos = 4]) / Volume"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-8\" and Pos = 4]) / Volume"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-9\" and Pos = 4]) / Volume"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-10\" and Pos = 4]) / Volume"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-11\" and Pos = 4]) / Volume"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-12\" and Pos = 4]) / Volume"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-13\" and Pos = 4]) / Volume"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-14\" and Pos = 4]) / Volume"
"reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-15\" and Pos = 4]) / Volume"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-16\" and Pos = 4]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-17\" and Pos = 4]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-18\" and Pos = 4]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-19\" and Pos = 4]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-20\" and Pos = 4]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-21\" and Pos = 4]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [Cellweight] of Microbes with [Name = \"reaction-22\" and Pos = 4]) / Volume"

PLOT
1540
810
1720
1010
Electron for energy generation (80-100 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-1\" and Pos = 4] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-2\" and Pos = 4] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-3\" and Pos = 4] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-4\" and Pos = 4] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-5\" and Pos = 4] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-6\" and Pos = 4] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-7\" and Pos = 4] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-8\" and Pos = 4] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-9\" and Pos = 4] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-10\" and Pos = 4] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-11\" and Pos = 4] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-12\" and Pos = 4] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-13\" and Pos = 4] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-14\" and Pos = 4] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-15\" and Pos = 4] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-16\" and Pos = 4]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-17\" and Pos = 4]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-18\" and Pos = 4]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-19\" and Pos = 4]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-20\" and Pos = 4]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-21\" and Pos = 4]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [EEG] of Microbes with [Name = \"reaction-22\" and Pos = 4]) / Volume"

PLOT
1715
810
1895
1010
Electron for cell synthesis (80-100 cm)
Time (min)
Amount of electron (mmol / L)
0.0
10.0
0.0
0.5
true
false
"" ""
PENS
"Reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-1\" and Pos = 4] / Volume) "
"Reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-2\" and Pos = 4] / Volume) "
"Reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-3\" and Pos = 4] / Volume) "
"Reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-4\" and Pos = 4] / Volume) "
"Reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-5\" and Pos = 4] / Volume)"
"Reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-6\" and Pos = 4] / Volume) "
"Reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-7\" and Pos = 4] / Volume) "
"Reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-8\" and Pos = 4] / Volume) "
"Reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-9\" and Pos = 4] / Volume) "
"Reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-10\" and Pos = 4] / Volume) "
"Reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-11\" and Pos = 4] / Volume) "
"Reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-12\" and Pos = 4] / Volume) "
"Reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-13\" and Pos = 4] / Volume) "
"Reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-14\" and Pos = 4] / Volume) "
"Reaction-15" 1.0 0 -5204280 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-15\" and Pos = 4] / Volume) "
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-16\" and Pos = 4]) / Volume"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-17\" and Pos = 4]) / Volume"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-18\" and Pos = 4]) / Volume"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-19\" and Pos = 4]) / Volume"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-20\" and Pos = 4]) / Volume"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-21\" and Pos = 4]) / Volume"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [ECS] of Microbes with [Name = \"reaction-22\" and Pos = 4]) / Volume"

PLOT
2055
810
2215
1010
E (80-100 cm)
Time (min)
E (mEq/L·h·gcell)
0.0
10.0
0.0
0.001
true
false
"" ""
PENS
"reaction-1" 1.0 0 -7500403 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-1\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-1\" and Pos = 4] )"
"reaction-2" 1.0 0 -2674135 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-2\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-2\" and Pos = 4] )"
"reaction-3" 1.0 0 -955883 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-3\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-3\" and Pos = 4] )"
"reaction-4" 1.0 0 -6459832 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-4\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-4\" and Pos = 4] )"
"reaction-5" 1.0 0 -1184463 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-5\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-5\" and Pos = 4] )"
"reaction-6" 1.0 0 -10899396 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-6\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-6\" and Pos = 4] )"
"reaction-7" 1.0 0 -13840069 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-7\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-7\" and Pos = 4] )"
"reaction-8" 1.0 0 -14835848 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-8\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-8\" and Pos = 4] )"
"reaction-9" 1.0 0 -11221820 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-9\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-9\" and Pos = 4] )"
"reaction-10" 1.0 0 -13791810 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-10\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-10\" and Pos = 4] )"
"reaction-11" 1.0 0 -13345367 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-11\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-11\" and Pos = 4] )"
"reaction-12" 1.0 0 -8630108 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-12\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-12\" and Pos = 4] )"
"reaction-13" 1.0 0 -5825686 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-13\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-13\" and Pos = 4] )"
"reaction-14" 1.0 0 -2064490 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-14\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-14\" and Pos = 4] )"
"reaction-15" 1.0 0 -6917194 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-15\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-15\" and Pos = 4] )"
"reaction-16" 1.0 0 -2758414 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-16\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-16\" and Pos = 4])"
"reaction-17" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-17\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-17\" and Pos = 4])"
"reaction-18" 1.0 0 -3425830 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-18\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-18\" and Pos = 4])"
"reaction-19" 1.0 0 -8020277 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-19\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-19\" and Pos = 4])"
"reaction-20" 1.0 0 -2382653 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-20\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-20\" and Pos = 4])"
"reaction-21" 1.0 0 -2754856 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-21\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-21\" and Pos = 4])"
"reaction-22" 1.0 0 -612749 true "" "plotxy time  (sum [item 4 tdd] of Microbes with [Name = \"reaction-22\" and Pos = 4]) / ( 0.00000000000000000001 + count Microbes with [Name = \"reaction-22\" and Pos = 4])"

TEXTBOX
580
15
595
46
↓
25
0.0
1

TEXTBOX
575
1065
590
1096
↓
25
0.0
1

TEXTBOX
560
1100
600
1118
Effluent
11
0.0
1

TEXTBOX
565
10
610
28
Influent
11
0.0
1

TEXTBOX
530
45
545
63
0
11
0.0
1

TEXTBOX
520
250
555
268
20 cm
11
0.0
1

TEXTBOX
520
445
555
463
40 cm
11
0.0
1

TEXTBOX
520
850
555
868
80 cm
11
0.0
1

TEXTBOX
520
650
555
668
60 cm
11
0.0
1

MONITOR
155
110
225
155
Time (min)
Time
17
1
11

SLIDER
275
75
430
108
hydraulic_loading
hydraulic_loading
1
6
6.0
1
1
m/h
HORIZONTAL

TEXTBOX
510
1050
545
1068
100 cm
11
0.0
1

BUTTON
15
75
225
108
clear-all-plots(to aviod memory run out)
clear-all-plots
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
15
110
85
155
Step_Time
Step_Time
17
1
11

INPUTBOX
80
105
155
165
update_time
240.0
1
0
Number

@#$#@#$#@
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

apple
false
0
Polygon -7500403 true true 33 58 0 150 30 240 105 285 135 285 150 270 165 285 195 285 255 255 300 150 268 62 226 43 194 36 148 32 105 35
Line -16777216 false 106 55 151 62
Line -16777216 false 157 62 209 57
Polygon -6459832 true false 152 62 158 62 160 46 156 30 147 18 132 26 142 35 148 46
Polygon -16777216 false false 132 25 144 38 147 48 151 62 158 63 159 47 155 30 147 18

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

banana
false
0
Polygon -7500403 false true 25 78 29 86 30 95 27 103 17 122 12 151 18 181 39 211 61 234 96 247 155 259 203 257 243 245 275 229 288 205 284 192 260 188 249 187 214 187 188 188 181 189 144 189 122 183 107 175 89 158 69 126 56 95 50 83 38 68
Polygon -7500403 true true 39 69 26 77 30 88 29 103 17 124 12 152 18 179 34 205 60 233 99 249 155 260 196 259 237 248 272 230 289 205 284 194 264 190 244 188 221 188 185 191 170 191 145 190 123 186 108 178 87 157 68 126 59 103 52 88
Line -16777216 false 54 169 81 195
Line -16777216 false 75 193 82 199
Line -16777216 false 99 211 118 217
Line -16777216 false 241 211 254 210
Line -16777216 false 261 224 276 214
Polygon -16777216 true false 283 196 273 204 287 208
Polygon -16777216 true false 36 114 34 129 40 136
Polygon -16777216 true false 46 146 53 161 53 152
Line -16777216 false 65 132 82 162
Line -16777216 false 156 250 199 250
Polygon -16777216 true false 26 77 30 90 50 85 39 69

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

caterpillar
true
0
Polygon -7500403 true true 165 210 165 225 135 255 105 270 90 270 75 255 75 240 90 210 120 195 135 165 165 135 165 105 150 75 150 60 135 60 120 45 120 30 135 15 150 15 180 30 180 45 195 45 210 60 225 105 225 135 210 150 210 165 195 195 180 210
Line -16777216 false 135 255 90 210
Line -16777216 false 165 225 120 195
Line -16777216 false 135 165 180 210
Line -16777216 false 150 150 201 186
Line -16777216 false 165 135 210 150
Line -16777216 false 165 120 225 120
Line -16777216 false 165 106 221 90
Line -16777216 false 157 91 210 60
Line -16777216 false 150 60 180 45
Line -16777216 false 120 30 96 26
Line -16777216 false 124 0 135 15

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cloud
false
0
Circle -7500403 true true 13 118 94
Circle -7500403 true true 86 101 127
Circle -7500403 true true 51 51 108
Circle -7500403 true true 118 43 95
Circle -7500403 true true 158 68 134

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

drop
false
0
Circle -7500403 true true 73 133 152
Polygon -7500403 true true 219 181 205 152 185 120 174 95 163 64 156 37 149 7 147 166
Polygon -7500403 true true 79 182 95 152 115 120 126 95 137 64 144 37 150 6 154 165

egg
false
0
Circle -7500403 true true 96 76 108
Circle -7500403 true true 72 104 156
Polygon -7500403 true true 221 149 195 101 106 99 80 148

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

lander
true
0
Polygon -7500403 true true 45 75 150 30 255 75 285 225 240 225 240 195 210 195 210 225 165 225 165 195 135 195 135 225 90 225 90 195 60 195 60 225 15 225 45 75

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

leaf 2
false
0
Rectangle -7500403 true true 144 218 156 298
Polygon -7500403 true true 150 263 133 276 102 276 58 242 35 176 33 139 43 114 54 123 62 87 75 53 94 30 104 39 120 9 155 31 180 68 191 56 216 85 235 125 240 173 250 165 248 205 225 247 200 271 176 275

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

petals
false
0
Circle -7500403 true true 117 12 66
Circle -7500403 true true 116 221 67
Circle -7500403 true true 41 41 67
Circle -7500403 true true 11 116 67
Circle -7500403 true true 41 191 67
Circle -7500403 true true 191 191 67
Circle -7500403 true true 221 116 67
Circle -7500403 true true 191 41 67
Circle -7500403 true true 60 60 180

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

suit diamond
false
0
Polygon -7500403 true true 150 15 45 150 150 285 255 150

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tooth
false
0
Polygon -7500403 true true 75 30 60 45 45 75 45 90 60 135 73 156 75 170 60 240 60 270 75 285 90 285 105 255 135 180 150 165 165 165 180 185 195 270 210 285 240 270 245 209 244 179 237 154 237 143 255 90 255 60 225 30 210 30 180 45 135 45 90 30
Polygon -7500403 false true 75 30 60 45 45 75 45 90 60 135 73 158 74 170 60 240 60 270 75 285 90 285 105 255 135 180 150 165 165 165 177 183 195 270 210 285 240 270 245 210 244 179 236 153 236 144 255 90 255 60 225 30 210 30 180 45 135 45 90 30 75 30

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
