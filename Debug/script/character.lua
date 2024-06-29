FOV = 70    -- 사용하지 않음

-- IDLE 애니메이션은 특정 시간이 지난 후 랜덤하게 바뀌게 한다.  (애니메이션이 존재할 경우)
IdleRandomMaxTick				= 5000

-- 맞았을때 애니메이션 실행 시간 ( 이 시간 이내에 들어오면 무시된다 )
HitAnimationMinTick				= 300

-- 등뒤 무기 붙힐 본 이름 
ChrBackWeaponBoneName = "spine01"



------------------------------------------------------------------------------
-- 캐릭터 변수
------------------------------------------------------------------------------
-- (float) 캐릭터 이동시 전/후/좌/우 Additive에 미치는 속도 영향 
InertiaMoveValue = 0.009

-- (float) 캐릭터 이동시 전/후/좌/우 Additive 회복에 미치는 속도 영향 
InertiaMoveReturnValue = 0.008

-- (float) 캐릭터 이동시 1인칭에 사용되는 관성값이며, 좌우, 최대 이동 값 
Max_InertiaMoveX = 1.0

-- (float) 위와 같으며, 좌우 최대 회전값
Max_InertiaLRRotZ = 1.0

-- (float) 위와 같으며, 전진/후진 최대 회전값
Max_InertiaFBRotX = 2.0

-- (float) 엎드리기 시에 상/하 제한 각
Max_ProneUpperAngle = -30.0 -- 수평선을 기준으로 상승 제한 각 (0 ~ -85)
Max_ProneLowerAngle = 30.0 -- 수평선을 기준으로 하향 제한 각 (0 ~ 85)

------------------------------------------------------------------------------
-- 숨참기 시간 (스나이퍼 무기(풀줌)에만 적용됨)
------------------------------------------------------------------------------
-- 풀줌시 Shift로 숨참기를 할 수 있는 최대 시간 (ms)
breathhold_time = 6000

-- 다시 숨참기를 할수 있는 최소 시간 (무기의 TriggerTime + hold_re_breath_min_time 시간으로 적용된다.) (ms)
re_breathhold_min_time = 3000

-- 두근 두근 거리는 심장 플레이 시간(ms)
breathhold_sound_play_time = 1000

-- sway 가 0이 되는 시간 (ms)
holdbreath_ready_time = 100 -- 기존 50 TEST중...

-- 숨참고 있을때 다시 튀어 나가는 최대 값  높을수록 많이 튄다.
holdbreath_reverse_power_max = 120

-- 튀어나갈때 holdbreath_reverse_power_max 에 몇을 곱해줄 것인가?  높을수록 더 크게 튄다.
holdbreath_reverse_power_rate = 0.35
overtime_holdbreath_reverse_power_rate = 1.0




