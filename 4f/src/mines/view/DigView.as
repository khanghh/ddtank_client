package mines.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mines.MinesManager;
   import mines.mornui.view.DigViewUI;
   import morn.core.handlers.Handler;
   import trainer.view.NewHandContainer;
   
   public class DigView extends DigViewUI
   {
      
      public static var doAction:Boolean = false;
       
      
      private var showView:DigShowView;
      
      private var mc:MovieClip;
      
      private var _currentLevel:int;
      
      private var timer:Timer;
      
      public function DigView(){super();}
      
      private function addEvent() : void{}
      
      override protected function initialize() : void{}
      
      private function createMc() : void{}
      
      private function changeHandler(param1:int) : void{}
      
      public function stopDig() : void{}
      
      private function levelUpTool(param1:Event) : void{}
      
      private function digHandler() : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      public function changeInfoLabel(param1:Event) : void{}
      
      protected function __onUpdateGrade(param1:PlayerPropertyEvent) : void{}
      
      private function show() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
