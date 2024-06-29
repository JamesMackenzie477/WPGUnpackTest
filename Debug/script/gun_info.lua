------------------------------------------------------------------------------
-- ���� ����Ʈ �� ���� ���� LUA ��ũ��Ʈ
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
		-- bone_name	= "fire" -- ����Ʈ�� ��µǴ� ���̸�
		-- angle_min	= 0.0 --�ּ� ����
		-- angle_max	= 45.0 -- �ִ� ���� / �ش� ���� �Ѿ�� ����Ʈ�� ǥ�õ��� ����
		-- dist_min	= 300.0 -- �ּ� �Ÿ� / �ش� �Ÿ� �̳����� �ְ�������� ����Ʈ ȿ���� ����
		-- dist_max	= 1500.0 -- �ִ� �Ÿ� / �ش� �Ÿ��� ����� ����Ʈ�� ǥ�õ��� ���� 
		-- size_min	= 0.0 -- ����Ʈ ȿ�� �ּ� ũ�Ⱚ
		-- size_max	= 500.0 -- ����Ʈ ȿ���� �ִ� ũ�Ⱚ / �߰������� ����޴� ����Ʈ�� ũ�Ⱚ�� ������ �Ÿ��� ���� �����ȴ�.
    -- end
    
    return texture, uv_left, uv_up, uv_right, uv_bottom, bone_name, angle_min, angle_max, dist_min, dist_max, size_min, size_max
	
end

------------------------------------------------------------------------------
-- ���� FIRE ���� ����Ʈ�� �ܺο��� �����ϵ��� �ϴ� ���
-- ����Ʈ �����̳ʴ� M4A1, Weapon191 �� ���� �Լ��� �ۼ��ϰ�, �׿� �´� ����Ʈ�� �ۼ��� �ش�
-- �׸��� GetEfffectMuzzleName() �Լ� ���� ���� �ε��� ��ȣ�� ������ ���ָ� �ȴ�.
-- 0000 ~ 0049  ���ݼ���
-- 0050 ~ 0059  AI�ѱ�
-- 0060 ~ 0109  �������
-- 0110 ~ 0149  ���ݼ���
-- 0150 ~ 0179  ������
-- 0180 ~ 0219  ����,��ź��,�������
-- 0220 ~ 0255  �߻��,��������,��ô���, ��Ÿ
------------------------------------------------------------------------------
-- weapon_number : gun_info �� ���� index �� ����.
-- view_mode  : 0 �� 1��Ī, 1�� 3��Ī�̴�.
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

-- ��Ÿ SW EFFECT
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

-- 180 �� Ư�� ���� EFFECT
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

-- 238 �� Ư�� ���� EFFECT ( metalreaper )
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

-- 245 �� Ư�� ���� EFFECT ( Hellbird weapon )
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


-- ���� EFFECT
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
