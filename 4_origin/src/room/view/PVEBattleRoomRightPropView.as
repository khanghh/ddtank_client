package room.view
{
   import battleSkill.BattleSkillManager;
   import battleSkill.event.BattleSkillEvent;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import room.RoomManager;
   
   public class PVEBattleRoomRightPropView extends BattleRoomRightPropView
   {
       
      
      public function PVEBattleRoomRightPropView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _combatskillIcon = ComponentFactory.Instance.creatComponentByStylename("ddtroom.battleSkill.setBtn");
         addChild(_combatskillIcon);
         if(_lastFightNumTxt)
         {
            _lastFightNumTxt.visible = false;
         }
         if(_lastFightValueTxt)
         {
            _lastFightValueTxt.visible = false;
         }
         if(_roomNameTxt)
         {
            _roomNameTxt.visible = false;
         }
         _energySprite = new Sprite();
         addChild(_energySprite);
         PositionUtils.setPos(_energySprite,"asset.room.lastEnergyPos");
         _energyBitmap = ComponentFactory.Instance.creat("asset.ddtroom.lastEnergy");
         _energySprite.addChild(_energyBitmap);
         _energyNum = ComponentFactory.Instance.creatComponentByStylename("room.lastEnergy.numText");
         _energyNum.text = PlayerManager.Instance.Self.energy.toString();
         _energySprite.addChild(_energyNum);
      }
      
      override protected function updateProView(evt:BattleSkillEvent) : void
      {
         var _skillInfo:* = null;
         var skillID:int = 0;
         var cellPlace:int = 0;
         var skillDic:Dictionary = BattleSkillManager.instance.getBringSkillList();
         var _loc8_:int = 0;
         var _loc7_:* = _allSkillCells;
         for(var key in _allSkillCells)
         {
            cellPlace = _allSkillCells[key].place;
            if(skillDic[cellPlace] == 0)
            {
               _allSkillCells[key].removeInfo();
            }
            else
            {
               if(RoomManager.Instance.current.type == 123)
               {
                  _skillInfo = HorseManager.instance.getHorseSkillInfoById(skillDic[cellPlace]);
                  if(_skillInfo && _skillInfo.GameType != 0)
                  {
                     continue;
                  }
               }
               _allSkillCells[key].skillId = skillDic[cellPlace];
            }
         }
      }
   }
}
