state("fceux", "2.2.3")
{
// ptr to zero page : 0x7B1388
// ptr to base for 6000 : 0x76A8A0
// WHY THE HELL DO I HAVE TO TYPE 3B AND NOT 7B AS THIS ADDRESS
// wtf asl

byte flips_to_zero_at_start : 0x3B1388, 0x4;

byte item_canoe : 0x36A8A0, 0x6031;

byte btl_result : 0x36A8A0, 0x6B86;
// 2 :: all enemies defeated

byte btlformation : 0x3B1388, 0x6A;
// 7B :: chaos
// 7A :: lich1
// 79 :: kary1
// 78 :: kraken1
// 77 :: tiamat1
// 73 :: lich2
// 74 :: kary2
// 75 :: kraken2
// 76 :: tiamat2
// 7F :: garland
}

split
{
  // if defeated enemies
  if (current.btl_result == 2 && old.btl_result == 0) {
    print("Completed a battle");
    print(current.btlformation.ToString());

    // garland
    if (settings["garland"] && current.btlformation == 0x7F) {
      print("Garland death");
      return(true);
    }

    // fiends v1
    if (settings["fiends"] && (current.btlformation == 0x7A || current.btlformation == 0x79 || current.btlformation == 0x78 || current.btlformation == 0x77)) {
      print("Fiend death");
      return(true);
    }

    // chaos
    if (settings["chaos"] && current.btl_formation == 0x7B) {
      print("Chaos death");
      return(true);
    }
  }
  // canoe
  if (settings["canoe"] && !vars.already_has_canoe && current.item_canoe == 1) {
      print("Canoe");
      vars.already_has_canoe = true;
      return(true);
  }
}

start
{
  if (old.flips_to_zero_at_start == 0xFF && current.flips_to_zero_at_start == 0) {
     vars.already_has_canoe = false;
     return(true);
  }
}

startup
{
	settings.Add("canoe", true, "Canoe");
	settings.Add("fiends", true, "Each fiend death (Fiend v1)");
	settings.Add("garland", true, "Garland death");
	settings.Add("chaos", true, "Chaos death");
}

