package room.view
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   
   public class RoomEqualityPropCell extends RoomPropCell
   {
       
      
      public function RoomEqualityPropCell(param1:Boolean, param2:int, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override protected function __mouseClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(_skillId == 0)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(_isself)
         {
            SocketManager.Instance.out.sendBallteHorseTakeUpDownSkill(0,_place + 1);
         }
         else
         {
            if(HorseManager.instance.isEqualSkillHasEquip(_skillId))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillCannotEquipSame"));
               return;
            }
            _loc2_ = HorseManager.instance.takeUpEqualSkillPlace;
            if(_loc2_ == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillEquipMax"));
               return;
            }
            SocketManager.Instance.out.sendBallteHorseTakeUpDownSkill(_skillId,_loc2_);
         }
      }
   }
}
