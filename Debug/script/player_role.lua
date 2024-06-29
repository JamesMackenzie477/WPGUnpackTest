local role_default_loadout = CharacterRole.new() -- 무기 사용기간이 만료되었을 때, 해당 로드아웃으로 설정

role_default_loadout:select_loadout( )
role_default_loadout:set_name( 'default_loadout' )
role_default_loadout:set_weapon( 'M4TRAINING' )
role_default_loadout:set_weapon( 'TAC-OPS' )
role_default_loadout:set_weapon( 'CLAW KNIFE' )
role_default_loadout:set_weapon( 'FLASH_GRENADE' )
role_default_loadout:set_weapon( 'FRAG_GRENADE' )
role_default_loadout:set_skill( 'Quick_aim')
role_default_loadout:set_skill( 'ammo_package')
role_default_loadout:set_skill( 'Fast_Hand')
role_default_loadout:set_drone( 'uav_recon', 0 )
role_default_loadout:set_drone( 'gorgon', 1 )
role_default_loadout:set_drone( 'escort', 2 )
role_default_loadout:save()

local role_sentinel = CharacterRole.new() -- 센티넬 헌트

role_sentinel:set_name( 'sentinel' )
role_sentinel:set_weapon( 'AK47' ) --AK47을 임시로 센티넬 무기로 설정
role_sentinel:set_weapon( 'MP443' )
role_sentinel:set_weapon( 'FLASH_GRENADE' )
role_sentinel:set_costume( 'sentinel-1' )
role_sentinel:set_skill( 'ammo_package' )
role_sentinel:save()

local role_hunter = CharacterRole.new()

role_hunter:set_name( 'hunter' )
role_hunter:set_weapon( 'MOSINNAGANT' ) -- 모신나강을 임시로 헌터 무기로 설정.
role_hunter:set_weapon( 'WOLVERINE' )
role_hunter:set_costume( 'sarah browning' )
role_hunter:set_skill( 'fast_sprint' )
role_hunter:save()

local role_sentinel_2 = CharacterRole.new() -- 도플갱어

role_sentinel_2:set_name( 'sentinel_2' )
role_sentinel_2:set_weapon( 'CROSSBOW_M', 0 )
role_sentinel_2:set_weapon( 'none', 1 )
role_sentinel_2:set_weapon( 'none', 2 )
role_sentinel_2:set_weapon( 'SMOKE_GRENADE' )
role_sentinel_2:set_costume( 'sentinel guard' )
role_sentinel_2:set_skill( 'assassin', 0 )
role_sentinel_2:set_skill( 'fast_sprint', 1 )
role_sentinel_2:set_skill( 'doppel', 2 )
role_sentinel_2:set_drone( 'crawler', 0 )
role_sentinel_2:set_drone( 'blade', 1 )
role_sentinel_2:set_drone( 'striker', 2 )
role_sentinel_2:save()

local role_tutorial = CharacterRole.new() -- 튜토리얼

role_tutorial:set_name( 'tutorial' )
role_tutorial:set_weapon( 'K2C' )
role_tutorial:set_weapon_attach( 'Monitor SIGHT' )
role_tutorial:set_weapon( 'TAC-OPS' )
role_tutorial:set_weapon( 'CLAW KNIFE' )
role_tutorial:set_weapon( 'FRAG_GRENADE' )
role_tutorial:set_drone( 'spy' )
role_tutorial:set_drone( 'escort' )
role_tutorial:set_drone( 'hellbird_t' )
role_tutorial:set_skill( 'vigor tutorial' )
role_tutorial:save()

local role_survivor = CharacterRole.new() -- 서바이벌 모드 PVP

role_survivor:set_name( 'survivor' )
role_survivor:set_weapon( 'CLAW KNIFE' )
role_survivor:set_weapon_slot( '9' )
role_survivor:save()

local role_weapon_test_1 = CharacterRole.new() -- 무기테스트1

role_weapon_test_1:set_name( 'weapon_test_1' )
role_weapon_test_1:set_weapon( 'MP5A5' )
role_weapon_test_1:set_weapon_attach( 'Clear SIGHT' )
role_weapon_test_1:set_weapon( 'TAC-OPS' )
role_weapon_test_1:set_weapon( 'CLAW KNIFE' )
role_weapon_test_1:set_drone( 'none', 0 )
role_weapon_test_1:set_drone( 'none', 1 )
role_weapon_test_1:set_drone( 'none', 2 )
role_weapon_test_1:save()

local role_weapon_test_2 = CharacterRole.new() -- 무기테스트2

role_weapon_test_2:set_name( 'weapon_test_2' )
role_weapon_test_2:set_weapon( 'AK12' )
role_weapon_test_2:set_weapon_attach( 'Clear SIGHT' )
role_weapon_test_2:set_weapon( 'TAC-OPS' )
role_weapon_test_2:set_weapon( 'CLAW KNIFE' )
role_weapon_test_2:set_drone( 'none', 0 )
role_weapon_test_2:set_drone( 'none', 1 )
role_weapon_test_2:set_drone( 'none', 2 )
role_weapon_test_2:save()

local role_knife_player = CharacterRole.new() -- 근접전

role_knife_player:select_loadout( )
role_knife_player:set_name( 'knife_player' )
role_knife_player:set_weapon( 'none', 0 )
role_knife_player:set_weapon( 'none', 1 )
role_knife_player:set_weapon( 'SMOKE_GRENADE' )
role_knife_player:set_weapon( 'THROWING_KNIFE' )
role_knife_player:set_skill( 'none', 0 )
role_knife_player:set_skill( 'none', 1 )
role_knife_player:set_skill( 'none', 2 )
role_knife_player:set_drone( 'stalker', 0 )
role_knife_player:set_drone( 'spy', 1 )
role_knife_player:set_drone( 'uav_recon', 2 )
role_knife_player:set_weapon_slot( '4' )
role_knife_player:save()

local role_sniper_player = CharacterRole.new() -- 저격전

role_sniper_player:select_loadout( )
role_sniper_player:set_name( 'sniper_player' )
role_sniper_player:set_weapon( 'DSR1' )
role_sniper_player:set_weapon( 'TAC-OPS' )
role_sniper_player:set_weapon( 'CLAW KNIFE', 4 )
role_sniper_player:set_weapon( 'SMOKE_GRENADE' )
role_sniper_player:set_weapon( 'CLAYMORE' )
role_sniper_player:set_skill( 'Quick_aim', 0 )
role_sniper_player:set_skill( 'none', 1 )
role_sniper_player:set_skill( 'none', 2 )
role_sniper_player:set_drone( 'stalker', 0 )
role_sniper_player:set_drone( 'observer', 1 )
role_sniper_player:set_drone( 'uav_recon', 2 )
role_sniper_player:save()