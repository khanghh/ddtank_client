package campbattle.view.roleView{   import campbattle.CampBattleControl;   import campbattle.data.RoleData;   import campbattle.event.MapEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import flash.display.MovieClip;   import flash.events.MouseEvent;   import flash.ui.Mouse;      public class CampBattleOtherRole extends CampBattlePlayer   {                   private var _sword:MovieClip;            public function CampBattleOtherRole(playerInfo:RoleData = null, callBack:Function = null) { super(null,null); }
            override protected function __onMouseOut(event:MouseEvent) : void { }
            override protected function __onMouseOver(event:MouseEvent) : void { }
            protected function mouseMoveHander(event:MouseEvent) : void { }
            override protected function __onMouseClick(e:MouseEvent) : void { }
            override public function dispose() : void { }
   }}