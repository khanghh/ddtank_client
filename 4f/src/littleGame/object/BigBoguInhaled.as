package littleGame.object
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Bounce;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.media.SoundChannel;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import littleGame.LittleGameManager;
   import littleGame.interfaces.ILittleObject;
   import littleGame.view.PriceShape;
   import littleGame.view.ScoreShape;
   
   public class BigBoguInhaled extends NormalBoguInhaled
   {
       
      
      private var _clickSoundChannel:SoundChannel;
      
      private var _soundPlaying:Boolean = false;
      
      private var _scoreShape:ScoreShape;
      
      private var _soundPlayVer:int;
      
      private var _scoreTween:Boolean = false;
      
      public function BigBoguInhaled(){super();}
      
      override public function get type() : String{return null;}
      
      override protected function removeEvent() : void{}
      
      override protected function drawInhaleAsset() : void{}
      
      private function __inhaleOnFrame(param1:Event) : void{}
      
      override protected function drawBackground() : void{}
      
      override public function execute() : void{}
      
      private function scoreTweenComplete() : void{}
      
      private function priceTweenIn(param1:DisplayObject) : void{}
      
      private function __soundComplete(param1:Event) : void{}
      
      override protected function __click(param1:MouseEvent) : void{}
      
      override protected function complete() : void{}
      
      private function start() : void{}
      
      override protected function __markComplete(param1:TimerEvent) : void{}
      
      override public function dispose() : void{}
   }
}
