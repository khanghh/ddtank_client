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
       
      
      public function PVEBattleRoomRightPropView(){super();}
      
      override protected function initView() : void{}
      
      override protected function updateProView(param1:BattleSkillEvent) : void{}
   }
}
