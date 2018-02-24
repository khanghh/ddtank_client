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
      
      public function CampBattleOtherRole(param1:RoleData = null, param2:Function = null){super(null,null);}
      
      override protected function __onMouseOut(param1:MouseEvent) : void{}
      
      override protected function __onMouseOver(param1:MouseEvent) : void{}
      
      protected function mouseMoveHander(param1:MouseEvent) : void{}
      
      override protected function __onMouseClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
