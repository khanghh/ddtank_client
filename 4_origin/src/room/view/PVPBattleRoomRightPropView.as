package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class PVPBattleRoomRightPropView extends BattleRoomRightPropView
   {
       
      
      public function PVPBattleRoomRightPropView()
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
         updateProView(null);
      }
   }
}
