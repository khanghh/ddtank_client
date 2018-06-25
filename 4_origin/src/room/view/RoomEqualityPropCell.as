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
       
      
      public function RoomEqualityPropCell(isself:Boolean, place:int, isHorse:Boolean = false)
      {
         super(isself,place,isHorse);
      }
      
      override protected function __mouseClick(evt:MouseEvent) : void
      {
         var tmpPlace:int = 0;
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
            tmpPlace = HorseManager.instance.takeUpEqualSkillPlace;
            if(tmpPlace == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillEquipMax"));
               return;
            }
            SocketManager.Instance.out.sendBallteHorseTakeUpDownSkill(_skillId,tmpPlace);
         }
      }
   }
}
