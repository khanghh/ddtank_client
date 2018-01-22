package game.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import trainer.view.NewHandContainer;
   
   public class GameDice extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _countDown:Bitmap;
      
      private var _time:Timer;
      
      private var countTime:int = 5;
      
      private var numSprite:Sprite;
      
      private var diceMc:MovieClip;
      
      private var _beginBtn:BaseButton;
      
      public var diceNum:int;
      
      public var leaderId:int;
      
      public function GameDice(){super();}
      
      private function init() : void{}
      
      private function _beginBtnHandler(param1:MouseEvent) : void{}
      
      public function roll() : void{}
      
      private function _timerHandler(param1:TimerEvent) : void{}
      
      private function diceJumpHandler(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
