package church.view.churchScene
{
   import church.ChurchManager;
   import church.model.ChurchRoomModel;
   import church.player.ChurchPlayer;
   import church.view.churchFire.ChurchFireEffectPlayer;
   import church.vo.FatherBallConfigVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.BitmapUtils;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class WeddingSceneMap extends SceneMap
   {
      
      public static const MOVE_SPEED:Number = 0.055;
      
      public static const MOVE_SPEEDII:Number = 0.15;
       
      
      private var _model:ChurchRoomModel;
      
      private var father_read:MovieClip;
      
      private var father_com:MovieClip;
      
      private var bride:ChurchPlayer;
      
      private var groom:ChurchPlayer;
      
      private var guestPos:Array;
      
      private var _fatherPaopaoBg:ScaleFrameImage;
      
      private var _fatherPaopao:ScaleFrameImage;
      
      private var _fatherPaopaoConfig:Array;
      
      private var frame:uint = 1;
      
      private var _brideName:FilterFrameText;
      
      private var _groomName:FilterFrameText;
      
      private var kissMovie:MovieClip;
      
      private var fireTimer:TimerJuggler;
      
      public function WeddingSceneMap(param1:ChurchRoomModel, param2:SceneScene, param3:DictionaryData, param4:Sprite, param5:Sprite, param6:Sprite = null, param7:Sprite = null){super(null,null,null,null,null,null,null);}
      
      private function initFather() : void{}
      
      public function fireImdily(param1:Point, param2:uint, param3:Boolean = false) : void{}
      
      public function playWeddingMovie() : void{}
      
      public function stopWeddingMovie() : void{}
      
      private function __arrive(param1:SceneCharacterEvent) : void{}
      
      public function rangeGuest() : void{}
      
      private function getGuestPos() : void{}
      
      private function spliceLine(param1:DisplayObject, param2:uint, param3:Boolean, param4:Boolean) : Array{return null;}
      
      private function playDialogue() : void{}
      
      private function playerFatherPaopaoFrame() : void{}
      
      private function readyForKiss() : void{}
      
      private function ajustPosition() : void{}
      
      private function hideDialogue() : void{}
      
      private function playKissMovie() : void{}
      
      private function stopKissMovie() : void{}
      
      public function playFireMovie() : void{}
      
      private function __fireTimer(param1:Event) : void{}
      
      private function getFirePosition() : Point{return null;}
      
      private function __fireTimerComplete(param1:TimerEvent) : void{}
      
      private function stopFireMovie() : void{}
      
      override protected function __click(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
