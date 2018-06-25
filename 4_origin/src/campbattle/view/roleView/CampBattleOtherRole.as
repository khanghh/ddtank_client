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
      
      public function CampBattleOtherRole(playerInfo:RoleData = null, callBack:Function = null)
      {
         super(playerInfo,callBack);
         if(playerInfo.team != CampBattleControl.instance.model.myTeam)
         {
            buttonMode = true;
         }
         _sword = ComponentFactory.Instance.creat("asset.CampBattle.overEnemySword");
         addChild(_sword);
         _sword.visible = false;
      }
      
      override protected function __onMouseOut(event:MouseEvent) : void
      {
         if(_sword)
         {
            _sword.visible = false;
         }
         Mouse.show();
         removeEventListener("mouseMove",mouseMoveHander);
         super.__onMouseOut(event);
      }
      
      override protected function __onMouseOver(event:MouseEvent) : void
      {
         if(CampBattleControl.instance.model.myTeam != _playerInfo.team || _playerInfo.stateType == 2)
         {
            if(_sword)
            {
               _sword.visible = true;
            }
            Mouse.hide();
            addEventListener("mouseMove",mouseMoveHander);
            super.__onMouseOver(event);
         }
      }
      
      protected function mouseMoveHander(event:MouseEvent) : void
      {
         if(_sword)
         {
            _sword.x = mouseX;
            _sword.y = mouseY;
         }
      }
      
      override protected function __onMouseClick(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
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
