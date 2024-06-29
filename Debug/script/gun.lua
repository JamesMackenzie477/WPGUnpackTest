Damage                         = 35
Dmgrate_Head					= 1.3
Dmgrate_Chest					= 1
Dmgrate_Arm					= 0.8
Dmgrate_Leg					= 0.8
Firerate					   = 950
Firetime					   = 100
FireAnimationtime					   = 333
Max_Range					   = 300000
ReloadTime					   = 2272
ReloadTime_Cancel			   = 2000
ChangeArms_Time				   = 2000
ChangeZoomin_Time			   = 200
MoveSpeedRate				   = 0.9
--SoundRange				   = 10000
--Magazine_Base				   = II_MAG_DEFAULT
Magazine_Full				   = 30
MaxAmmo						   = 10000
TracerRate					   = 5
PenetrationPower			   = 0
SpreadValue					   = 50
SpreadRecoverySpeed			   = 100
SpreadValue_Zoomin			   = 50
SRS_Zoomin					   = 100
SRS_Viewrotate				   = 110
SRS_StanceChange			   = 110
SpreadValue_Viewrotate		   = 0.1
SpreadStand_Min				   = 26
SpreadStand_Max				   = 38
SpreadZoom_Min				   = 5
SpreadZoom_Max				   = 8
SpreadRate_Crouch			   = 0.84
SpreadRate_Prone			   = 0.7
SpreadRate_Walk				   = 1.39
SpreadRate_Run				   = 1.39
SpreadRate_Jump				   = 1.39
SpreadProbabilityArea_Core	   = 0.2
SpreadProbabilityArea_Middle   = 0.6
SpreadProbabilityValue_Core	   = 0.5
SpreadProbabilityValue_Middle  = 0.3
SpreadProbabilityValue_Max	   = 0.2
RecoilMax					   = 10
RecoilMax_Left				   = -10
RecoilMax_Right				   = 10
RecoilPower_Base			   = 0.375
RecoilPower_Add				   = 0.5
RecoilRate_Left				   = 0.5
RecoilInertia_Left			   = 0
RecoilInertia_Right			   = 0
RecoilValue_Left			   = 0.25
RecoilValue_Right              = 0.25
RecoilRecoverySpeed            = 3.75
RecoilZoominOffsetRate         = 0.3




-- - - - - - - - - - - - - - - - - - -
-- 
-- recoil angle 생성
--
  
recoilCount = 0
recoilLastDelta = 0

function getRecoilAngle()
 
   -- 반동 관성 적용
   if recoilCount == 0 then
   
      -- 관성이 없는 경우
      local probability = math.random()

      -- 왼쪽 회전 확률인지   
      if probability<RecoilRate_Left then
      
        recoilLastDelta = -RecoilValue_Left
        recoilCount = RecoilInertia_Left
        
      else
        
        recoilLastDelta = RecoilValue_Right
        recoilCount = RecoilInertia_Right
        
      end
      
   else 
   
      -- 반동 관성 횟수 -1
      -- 반동 회전값은 예전의 recoilLastDelta 를 그대로 사용
      
      recoilCount = recoilCount - 1
      
   end
   
   -- x 축 recoil 계산
   local recoilX = math.random()*RecoilPower_Add + RecoilPower_Base
   
   return  recoilX,recoilLastDelta
   
end
