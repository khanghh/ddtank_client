package zodiac
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import quest.TaskManager;
   
   public class ZodiacRollingView extends Sprite implements Disposeable
   {
       
      
      private var _rollingBtn:MovieClip;
      
      private var btndarkArr:Array;
      
      private var btnShineArr:Array;
      
      private var currentBtn:Image;
      
      private var paopaoArr:Array;
      
      private var finalMovie:MovieClip;
      
      private var _last:int;
      
      private var rollrace:int;
      
      private var rollcount:int;
      
      private var indexpaopao:int;
      
      private var endpaopao:int;
      
      public function ZodiacRollingView(){super();}
      
      public function rolling(param1:int) : void{}
      
      private function startrolling() : void{}
      
      private function rolltest() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __rolloverHandler(param1:MouseEvent) : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      private function __rollingHandler(param1:MouseEvent) : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      private function onCompleteHandler() : void{}
      
      private function __ballClickHandler(param1:MouseEvent) : void{}
      
      public function update() : void{}
      
      private function refreshBallState() : void{}
      
      private function refreshShineState() : void{}
      
      private function hideFinalMovie() : void{}
      
      private function showFinalMovie(param1:int) : void{}
      
      private function addCurrentPaopao(param1:int) : void{}
      
      private function removeCurrentPaopao() : void{}
      
      private function rollingComplete(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
