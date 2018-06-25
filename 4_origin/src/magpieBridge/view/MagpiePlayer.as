package magpieBridge.view
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
   
   public class MagpiePlayer extends WorldRoomPlayerBase
   {
       
      
      private var _sceneCharacterDirection:Object;
      
      private var _timer:Timer;
      
      private var _walkArray:Array;
      
      private var _oldIndex:int;
      
      private var index:int;
      
      private var _isWalk:Boolean;
      
      private var _isMir:Boolean;
      
      private var _light:MovieClip;
      
      public function MagpiePlayer(playerInfo:PlayerInfo, callBack:Function = null)
      {
         super(playerInfo,callBack);
         _light = ComponentFactory.Instance.creat("buried.dice.footLigth");
         _light.x = -282;
         _light.y = 38;
         this.character.y = 15;
         addChild(_light);
         addEventListener("characterDirectionChange",characterDirectionChange);
         addEventListener("enterFrame",enterFrameHander);
      }
      
      private function enterFrameHander(e:Event) : void
      {
         update();
      }
      
      public function refreshCharacterState() : void
      {
         if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
         {
            sceneCharacterActionType = "naturalWalkBack";
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
         {
            sceneCharacterActionType = "naturalWalkFront";
         }
      }
      
      public function set setSceneCharacterDirectionDefault(value:SceneCharacterDirection) : void
      {
         if(sceneCharacterStateType == "natural")
         {
            sceneCharacterActionType = "naturalStandFront";
         }
      }
      
      private function characterMirror($x:int) : void
      {
         if(!isDefaultCharacter)
         {
            if($x > x)
            {
               this.character.scaleX = -1;
               this.character.x = playerWitdh - 3;
            }
            else
            {
               this.character.scaleX = 1;
               this.character.x = -3;
            }
         }
         else
         {
            this.character.scaleX = 1;
            this.character.x = -3;
         }
      }
      
      public function roleWalk(array:Array) : void
      {
         index = 0;
         _isWalk = true;
         _walkArray = array;
         dispatchEvent(new SceneCharacterEvent("characterDirectionChange",true));
         characterMirror(_walkArray[index].x);
         TweenMax.to(this,0.3,{
            "x":array[index].x,
            "y":array[index].y,
            "onComplete":comp,
            "ease":Linear.easeNone
         });
      }
      
      private function comp() : void
      {
         index = Number(index) + 1;
         if(index < _walkArray.length)
         {
            characterMirror(_walkArray[index].x);
            refreshCharacterState();
            TweenMax.to(this,0.3,{
               "x":_walkArray[index].x,
               "y":_walkArray[index].y,
               "onComplete":comp,
               "ease":Linear.easeNone
            });
         }
         else
         {
            _isWalk = false;
            dispatchEvent(new MagpieBridgeEvent("walkOver"));
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         }
      }
      
      private function characterDirectionChange(e:SceneCharacterEvent) : void
      {
         if(e.data)
         {
            if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
            {
               if(sceneCharacterStateType == "natural")
               {
                  sceneCharacterActionType = "naturalWalkBack";
               }
            }
            else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
            {
               if(sceneCharacterStateType == "natural")
               {
                  sceneCharacterActionType = "naturalWalkFront";
               }
            }
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
         {
            if(sceneCharacterStateType == "natural")
            {
               sceneCharacterActionType = "naturalStandBack";
            }
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
         {
            if(sceneCharacterStateType == "natural")
            {
               sceneCharacterActionType = "naturalStandFront";
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("characterDirectionChange",characterDirectionChange);
         removeEventListener("enterFrame",enterFrameHander);
         super.dispose();
      }
   }
}
