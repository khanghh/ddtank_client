package wonderfulActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.views.IRightView;
   
   public class FarmView extends Sprite implements IRightView
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _back:Bitmap;
      
      private var endData:Date;
      
      private var nowdate:Date;
      
      private var _timerTxt:FilterFrameText;
      
      public function FarmView(){super();}
      
      public function init() : void{}
      
      public function setState(param1:int, param2:int) : void{}
      
      private function initTimer() : void{}
      
      private function farmeTimerHander() : void{}
      
      protected function mouseClickHander(param1:MouseEvent) : void{}
      
      public function content() : Sprite{return null;}
      
      public function dispose() : void{}
   }
}
