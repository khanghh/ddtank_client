package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GameCountDownView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _hundredsTxt:FilterFrameText;
      
      private var _tensTxt:FilterFrameText;
      
      private var _unitTxt:FilterFrameText;
      
      private var _total:int;
      
      private var _timer:Timer;
      
      public function GameCountDownView(param1:int){super();}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function refreshTxt() : void{}
      
      public function dispose() : void{}
   }
}
