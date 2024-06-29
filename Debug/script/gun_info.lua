------------------------------------------------------------------------------
-- 무기 이펙트 및 무기 관련 LUA 스크립트
------------------------------------------------------------------------------

function GetFlareInfo(weapon_number)
    
	texture 	= ""
	uv_left		= 0.0
	uv_up		= 0.0
	uv_right	= 0.0
	uv_bottom	= 0.0
	bone_name	= ""
	angle_min	= 0.0
	angle_max	= 0.0
	dist_min	= 0.0
	dist_max	= 0.0
	size_min	= 0.0
	size_max	= 0.0
	
	-- Px4Storm
    -- if(weapon_number == 182) then
		-- texture 	= "ui\\drone\\greenflare.dds"
		-- uv_left		= 0.0
		-- uv_up		= 0.0
		-- uv_right	= 1.0
		-- uv_bottom	= 1.0
		-- bone_name	= "fire" -- 이펙트가 출력되는 본이름
		-- angle_min	= 0.0 --최소 각도
		-- angle_max	= 45.0 -- 최대 각도 / 해당 값을 넘어가면 이펙트가 표시되지 않음
		-- dist_min	= 300.0 -- 최소 거리 / 해당 거리 이내에는 최고사이즈의 이펙트 효과를 받음
		-- dist_max	= 1500.0 -- 최대 거리 / 해당 거리를 벗어나면 이펙트가 표시되지 않음 
		-- size_min	= 0.0 -- 이펙트 효과 최소 크기값
		-- size_max	= 500.0 -- 이펙트 효과의 최대 크기값 / 추가적으로 영향받는 이펙트의 크기값은 각도와 거리에 따라 결정된다.
    -- end
    
    return texture, uv_left, uv_up, uv_right, uv_bottom, bone_name, angle_min, angle_max, dist_min, dist_max, size_min, size_max
	
end

------------------------------------------------------------------------------
-- 무기 FIRE 머즐 이펙트를 외부에서 편집하도록 하는 기능
-- 이펙트 디자이너는 M4A1, Weapon191 과 같이 함수를 작성하고, 그에 맞는 이펙트를 작성해 준다
-- 그리고 GetEfffectMuzzleName() 함수 내에 무기 인덱스 번호와 연결을 해주면 된다.
-- 0000 ~ 0049  돌격소총
-- 0050 ~ 0059  AI총기
-- 0060 ~ 0109  기관단총
-- 0110 ~ 0149  저격소총
-- 0150 ~ 0179  경기관총
-- 0180 ~ 0219  권총,산탄총,기관권총
-- 0220 ~ 0255  발사기,근접무장,투척장비, 기타
------------------------------------------------------------------------------
-- weapon_number : gun_info 의 무기 index 와 같다.
-- view_mode  : 0 은 1인칭, 1은 3인칭이다.
function GetEfffectMuzzleName(weapon_number, view_mode)
    
    if (    weapon_number >= 0   ) and ( weapon_number <=  49 ) then muzzle_name, smoke_name = AREffect(view_mode);
    elseif (weapon_number >= 60  ) and ( weapon_number <= 109 ) then muzzle_name, smoke_name = SMGEffect(view_mode);
    elseif (weapon_number >= 110 ) and ( weapon_number <= 149 ) then muzzle_name, smoke_name = SnipeEffect(view_mode);
    elseif (weapon_number >= 150 ) and ( weapon_number <= 179 ) then muzzle_name, smoke_name = SWEffect(view_mode);
    elseif (weapon_number == 180 )                                    then muzzle_name, smoke_name = Weapon180Effect(view_mode);
    elseif (weapon_number >= 180 ) and ( weapon_number <= 185 ) then muzzle_name, smoke_name = GunEffect(view_mode);
    elseif (weapon_number >= 190 ) and ( weapon_number <= 191 ) then muzzle_name, smoke_name = ShotgunEffect(view_mode);
    elseif (weapon_number == 238 )                                    then muzzle_name, smoke_name = Weapon238Effect(view_mode);
    elseif (weapon_number == 246 )                                    then muzzle_name, smoke_name = Weapon245Effect(view_mode);
    elseif (weapon_number == 9101)                                    then muzzle_name, smoke_name = "";
    else                                                              muzzle_name, smoke_name = Default(view_mode);
    
    end
    
    return muzzle_name, smoke_name
end

-- AR EFFECT
function AREffect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke.bfx"
    else
        muzzle_name = "effects\\effect_weapon\\muzzleside_ar.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_side.bfx"    
    end
    return muzzle_name, smoke_name
end

-- SMG EFFECT
function SMGEffect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle_smg.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_smg.bfx"    
    else
        muzzle_name = "effects\\effect_weapon\\muzzleside_smg.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_side.bfx"    
    end
    return muzzle_name, smoke_name
end

-- SNIPER EFFECT
function SnipeEffect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle_sniper.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_sniper.bfx"    
    else
        muzzle_name = "effects\\effect_weapon\\muzzleside.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_side.bfx"    
    end
    return muzzle_name, smoke_name
end

-- 기타 SW EFFECT
function SWEffect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle_lmg.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_lmg.bfx"   
    else
        muzzle_name = "effects\\effect_weapon\\muzzleside.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_side.bfx"    
    end
    return muzzle_name, smoke_name
end

-- 180 번 특정 무기 EFFECT
function Weapon180Effect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke.bfx"    
    else
        muzzle_name = "effects\\effect_weapon\\muzzleside.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_side.bfx"    
    end
    return muzzle_name, smoke_name
end

-- 238 번 특정 무기 EFFECT ( metalreaper )
function Weapon238Effect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = ""
        smoke_name = ""    
    else
        muzzle_name = ""
        smoke_name = ""    
    end
    return muzzle_name, smoke_name
end

-- 245 번 특정 무기 EFFECT ( Hellbird weapon )
function Weapon245Effect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle_hell.bfx"
        smoke_name = "effects\\effect_weapon\\muzzle_hell_smoke.bfx"    
    else
        muzzle_name = "effects\\effect_weapon\\muzzle_hell.bfx"
        smoke_name = "effects\\effect_weapon\\muzzle_hell_smoke.bfx"    
    end
    return muzzle_name, smoke_name
end


-- 권총 EFFECT
function GunEffect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle_pistol.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke.bfx"   
    else
        muzzle_name = "effects\\effect_weapon\\muzzleside_pistol.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_side_pistol.bfx"    
    end
    return muzzle_name, smoke_name
end

-- SHOTGUN EFFECT
function ShotgunEffect(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle_buckshot.bfx"
        smoke_name  = "effects\\effect_weapon\\muzzlesmoke_buckshot.bfx"
    else
        muzzle_name = "effects\\effect_weapon\\muzzleside_shotgun.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_side_sg.bfx"    
    end

    return muzzle_name, smoke_name
end

function Default(view_mode)
    if( view_mode == 0 ) then
        muzzle_name = "effects\\effect_weapon\\muzzle.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke.bfx"    
    else
        muzzle_name = "effects\\effect_weapon\\muzzleside.bfx"
        smoke_name = "effects\\effect_weapon\\muzzlesmoke_side.bfx"    
    end
    return muzzle_name, smoke_name
end
