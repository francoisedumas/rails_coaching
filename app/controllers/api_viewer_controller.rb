class ApiViewerController < ApplicationController
  def index
    @pagy, @vessels = pagy_array(cache_answer)
  end

  private

  def cache_answer
    Rails.cache.fetch("api_response", expires_in: 12.hours) do
      ApiViewerService.call(sub_path: "construction-specs")
    end
  end

  def local_answer
    path = Rails.root.join("tmp", "api_response.json")
    file_content = File.read(path)
    JSON.parse(file_content)
  end

  def temp_response
    [{"vessel"=>"ACTA AURIGA", "vesselId"=>917, "pipelay"=>false, "wind"=>false, "vesselManager"=>"Siemens Gamesa", "vesselImageURI"=>"https://photos.marinetraffic.com/ais/showphoto.aspx?photoid=3298725", "vesselType"=>"Vessel", "vfDateStart"=>0, "detailedShapeCode"=>"vessel", "design"=>"Ulstein SX195", "loa"=>93.4, "surveyMarketed"=>false, "surveyDrillingSystem"=>false, "seismicCapable"=>false, "surveyCpt"=>false, "beam"=>18, "depth"=>7.6, "maxOperatingDraft"=>6, "grossTonnage"=>6050, "deadWeightTonnage"=>2600, "jackupSelfPropelled"=>false, "maxPob"=>120, "dpSystem"=>"DP2", "mooringCapable"=>false, "fuelCapacity"=>800, "rovCapable"=>false, "activeHeaveCompensation"=>true, "motionCompensatedPileGripper"=>false, "tiltablePileGripper"=>false, "deckArea"=>500, "deckCargoCapacity"=>650, "jLay"=>false, "reelLay"=>false, "sLay"=>false, "flexLay"=>false, "dsv"=>false, "latest"=>true, "wellIntervention"=>false, "handlingTower"=>false, "gangway"=>true, "helideck"=>false, "accommodationMarketed"=>false, "title"=>"ACTA AURIGA", "yearBuilt"=>2018, "buildCountry"=>"Norway", "builder"=>"ULSTEIN VERFT AS", "bweSystem"=>1, "flagCountry"=>"Netherlands", "imo"=>9822815, "mmsi"=>244090781, "sov"=>true, "daughterCraft"=>false, "dateNextSurvey"=>1836259200000, "ahtCapable"=>false, "supplyMarketed"=>false, "ctv"=>false, "jonesAct"=>false, "consumptionAtDp"=>3.67, "refuelingService"=>false, "vesselMainPurpose"=>"SOV", "maxConnectionWaveHeightClc"=>3, "maxRegularConnectionWaveHeightClc"=>2.1, "transitMaxSpeed"=>13, "transitServiceSpeedClc"=>8, "transitMaxSpeedClc"=>14, "fireFighting"=>false, "classNotation"=>"I ✠ Hull ✠ Mach, Special service, /Offshore service vessel, SP, -heavycargo, ✠ OAS , COMF-NOISE 2 , COMF-VIB 2 , ✠ AUT-UMS , ✠ SYS-NEQ , GREEN PASSPORT , BWT , CLEANSHIP , INWATERSURVEY , ✠ DYNAPOS AM/AT R , SDS", "environmentalClass"=>"CLEANSHIP", "standbyClass"=>false, "iceClass"=>false, "oilRecClass"=>false, "classSociety"=>"Bureau Veritas", "rockInstallation"=>false, "ess"=>false, "shorePowerConnection"=>false, "scr"=>false, "scrubber"=>0, "owner"=>"ACTA SHIPPING 2 BV ", "ownerCountry"=>"Netherlands", "usv"=>false, "classSocietyUrl"=>"https://marine-offshore.bureauveritas.com/bv-fleet/#/bv-fleet/", "charterDateEnd"=>1735640846000, "featureManager"=>"Acta Marine", "vesselStatus"=>"On hire", "noAisTracking"=>0, "isNotRetired"=>1, "currentProjectActivityShortTitle"=>"Fecamp - Construction", "currentProjectActivityStatus"=>"Done", "currentOperator"=>"EDF", "dredger"=>false, "aisFrontRatio"=>0.394, "aisLeftRatio"=>0.5, "environmentalScore"=>54, "environmentalScore10"=>50, "environmentalScore5"=>55, "environmentalScoreComment"=>"Built 2018, Environmental notation: Cleanship, Time spent in ECA in the last 12 months, Time spent in ECA in the last 5 years, Overspeeding in the last 12 months", "competitive"=>true, "analystValidated"=>"Validated", "dualCrane"=>false, "mainHoistCapacity"=>20, "totalLiftingCapacity"=>20, "hopperCapable"=>0, "spud"=>0, "roRo"=>0, "co2Carrier"=>0, "fpso"=>false, "fullAisHistory"=>true, "currentCountryId"=>"fr", "currentActivityStatus"=>"Transit", "vesselMainPurposeWindfarmOps"=>"SOV", "daughterVesselTitles"=>["ACTA AURIGA FRC"], "daughterVesselIds"=>[11343], "charterInfo"=>"Chartered from Acta Marine to Siemens Gamesa until 2024-12-31", "charterFromManager"=>"Acta Marine", "craneCategory"=>"< 400t", "layTypeFilter"=>[], "vesselSupplyStatus"=>"On hire", "isNotInConstruction"=>true, "statusProba"=>0, "dateYearBuilt"=>1514764800000, "lowEmissionFuelCapable"=>false, "currentCountry"=>"France", "currentRegion"=>"North Sea (Inc. baltic Sea)"}]
  end
end
