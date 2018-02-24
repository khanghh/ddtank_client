package ddtBuried.role
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.player.PlayerInfo;
   import ddt.events.SceneCharacterEvent;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Timer;
   import magpieBridge.event.MagpieBridgeEvent;
   import worldboss.player.WorldRoomPlayerBase;
   
   public class BuriedPlayer extends WorldRoomPlayerBase
   {
       
      
      private var _sceneCharacterDirection:Object;
      
      private var _timer:Timer;
      
      private var _walkArray:Array;
      
      private var _oldIndex:int;
      
      private var index:int;
      
      private var _isWalk:Boolean;
      
      private var _isMir:Boolean;
      
      private var _light:MovieClip;
      
      public function BuriedPlayer(param1:PlayerInfo, param2:Function = null){super(null,null);}
      
      private function enterFrameHander(param1:Event) : void{}
      
      public function refreshCharacterState() : void{}
      
      public function set setSceneCharacterDirectionDefault(param1:SceneCharacterDirection) : void{}
      
      private function characterMirror(param1:int) : void{}
      
      public function roleWalk(param1:Array) : void{}
      
      private function comp() : void{}
      
      private function characterDirectionChange(param1:SceneCharacterEvent) : void{}
      
      override public function dispose() : void{}
   }
}
