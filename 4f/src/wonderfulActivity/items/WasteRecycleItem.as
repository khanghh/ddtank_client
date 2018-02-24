package wonderfulActivity.items
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.utils.DateUtils;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import wasteRecycle.WasteRecycleController;
   import wasteRecycle.WasteRecycleManager;
   import wonderfulActivity.views.IRightView;
   
   public class WasteRecycleItem extends Sprite implements IRightView
   {
       
      
      private var _bg:Bitmap;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _timeText:FilterFrameText;
      
      private var _activityTime:Number;
      
      private var _timer:TimerJuggler;
      
      public function WasteRecycleItem(){super();}
      
      public function init() : void{}
      
      private function __onTimer(param1:Event) : void{}
      
      private function __onOpen(param1:MouseEvent) : void{}
      
      public function content() : Sprite{return null;}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function dispose() : void{}
   }
}
