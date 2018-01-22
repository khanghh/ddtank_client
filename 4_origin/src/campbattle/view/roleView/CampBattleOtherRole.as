package campbattle.view.roleView
{
   import campbattle.CampBattleControl;
   import campbattle.data.RoleData;
   import campbattle.event.MapEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class CampBattleOtherRole extends CampBattlePlayer
   {
       
      
      private var _sword:MovieClip;
      
      public function CampBattleOtherRole(param1:RoleData = null, param2:Function = null)
      {
         super(param1,param2);
         if(param1.team != CampBattleControl.instance.model.myTeam)
         {
            buttonMode = true;
         }
         _sword = ComponentFactory.Instance.creat("asset.CampBattle.overEnemySword");
         addChild(_sword);
         _sword.visible = false;
      }
      
      override protected function __onMouseOut(param1:MouseEvent) : void
      {
         if(_sword)
         {
            _sword.visible = false;
         }
         Mouse.show();
         removeEventListener("mouseMove",mouseMoveHander);
         super.__onMouseOut(param1);
      }
      
      override protected function __onMouseOver(param1:MouseEvent) : void
      {
         if(CampBattleControl.instance.model.myTeam != _playerInfo.team || _playerInfo.stateType == 2)
         {
            if(_sword)
            {
               _sword.visible = true;
            }
            Mouse.hide();
            addEventListener("mouseMove",mouseMoveHander);
            super.__onMouseOver(param1);
         }
      }
      
      protected function mouseMoveHander(param1:MouseEvent) : void
      {
         if(_sword)
         {
            _sword.x = mouseX;
            _sword.y = mouseY;
         }
      }
      
      override protected function __onMouseClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(_playerInfo.team != CampBattleControl.instance.model.myTeam)
         {
            CampBattleControl.instance.dispatchEvent(new MapEvent("goto_fight",[_playerInfo.posX,_playerInfo.posY,_playerInfo.zoneID,_playerInfo.ID]));
         }
         else if(_playerInfo.stateType == 2)
         {
            CampBattleControl.instance.dispatchEvent(new MapEvent("goto_fight",[_playerInfo.posX,_playerInfo.posY,_playerInfo.zoneID,_playerInfo.ID]));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_sword);
         _sword = null;
      }
   }
}
