package escort.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class EscortBuffCountDownView extends Sprite implements Disposeable
   {
      
      public static const END:String = "EscortBuffCountDownEnd";
       
      
      private var _bg:Bitmap;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _titleTxt:FilterFrameText;
      
      private var _endTime:Date;
      
      private var _timer:Timer;
      
      private var _type:int;
      
      private const colorList:Array = [16711680,1813759,59158];
      
      public function EscortBuffCountDownView(param1:Date, param2:int, param3:int){super();}
      
      public function get type() : int{return 0;}
      
      public function set endTime(param1:Date) : void{}
      
      private function refreshTxt(param1:TimerEvent) : void{}
      
      public function dispose() : void{}
   }
}
