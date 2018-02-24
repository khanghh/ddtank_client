package gameCommon.view
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import gameCommon.view.smallMap.GameTurnButton;
   
   public class DungeonHelpView extends Sprite implements Disposeable
   {
       
      
      private var _isFirst:Boolean;
      
      protected var _closeBtn:SimpleBitmapButton;
      
      private var _time:Timer;
      
      private var _opened:Boolean;
      
      protected var _container:Sprite;
      
      private var _winTxt1:FilterFrameText;
      
      private var _winTxt2:FilterFrameText;
      
      private var _lostTxt1:FilterFrameText;
      
      private var _lostTxt2:FilterFrameText;
      
      private var _arrow1:Bitmap;
      
      private var _arrow2:Bitmap;
      
      private var _arrow3:Bitmap;
      
      private var _arrow4:Bitmap;
      
      private var _tweened:Boolean = false;
      
      protected var _turnButton:GameTurnButton;
      
      private var _barrier:DungeonInfoView;
      
      private var _gameContainer:DisplayObjectContainer;
      
      protected var _sourceRect:Rectangle;
      
      private var _showed:Boolean = false;
      
      public function DungeonHelpView(param1:GameTurnButton, param2:DungeonInfoView, param3:DisplayObjectContainer){super();}
      
      protected function init() : void{}
      
      private function closeComplete() : void{}
      
      private function openComplete() : void{}
      
      public function open() : void{}
      
      public function close(param1:Rectangle) : void{}
      
      private function __sleepOrStop() : void{}
      
      protected function __timerComplete(param1:TimerEvent) : void{}
      
      protected function clearTime() : void{}
      
      private function setText() : void{}
      
      public function defaultClose() : void{}
      
      public function dispose() : void{}
      
      private function __startEffect(param1:Event) : void{}
      
      protected function __closeHandler(param1:MouseEvent) : void{}
      
      public function get opened() : Boolean{return false;}
      
      public function get showed() : Boolean{return false;}
   }
}
