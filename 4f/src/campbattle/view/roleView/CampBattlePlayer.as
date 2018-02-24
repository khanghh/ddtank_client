package campbattle.view.roleView
{
   import campbattle.data.RoleData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class CampBattlePlayer extends CampBaseRole
   {
       
      
      public var scene:SceneScene;
      
      protected var tombstone:MovieClip;
      
      protected var fighting:MovieClip;
      
      protected var capture:Bitmap;
      
      private var _walkOverHander:Function;
      
      private var _targetID:int;
      
      private var _targetZoneID:int;
      
      private var _nameTxt:FilterFrameText;
      
      private var _resurrectCartoon:MovieClip;
      
      private var _currentWalkStartPoint:Point;
      
      private var _walkSpeed:Number;
      
      public function CampBattlePlayer(param1:RoleData = null, param2:Function = null){super(null,null);}
      
      private function setPlayerWalkSpeed() : void{}
      
      public function setPlayerInfo(param1:RoleData = null) : void{}
      
      private function initStatus() : void{}
      
      public function setCaptureVisible(param1:Boolean) : void{}
      
      private function cartoonCompleteHandler(param1:Event) : void{}
      
      public function setStateType(param1:int) : void{}
      
      override public function dispose() : void{}
      
      protected function enterFrameHander(param1:Event) : void{}
      
      public function walk(param1:Point, param2:Function = null, param3:int = 0, param4:int = 0) : void{}
      
      protected function characterMirror() : void{}
      
      protected function playerWalkPath() : void{}
      
      override public function playerWalk(param1:Array) : void{}
      
      private function setPlayerDirection() : SceneCharacterDirection{return null;}
      
      public function IsShowPlayer(param1:Boolean) : void{}
      
      private function characterDirectionChange(param1:SceneCharacterEvent) : void{}
      
      public function get playerInfo() : RoleData{return null;}
   }
}
