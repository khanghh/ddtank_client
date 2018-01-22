package ddtKingFloat.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DDTKingFloatSprintCountDown extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _recordTxt:String;
      
      private var _timer:Timer;
      
      private var _endTime:Date;
      
      public function DDTKingFloatSprintCountDown()
      {
         super();
         this.x = 340;
         this.y = 34;
         initView();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("ddtKing.countDownBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.countDownView.txt");
         _recordTxt = LanguageMgr.GetTranslation("escort.frame.sprintCountDownViewTxt");
         _txt.text = _recordTxt + "--:--";
         addChild(_bg);
         addChild(_txt);
      }
      
      public function setCountDown(param1:Date) : void
      {
         _timer.start();
         _endTime = param1;
         refreshView(_endTime);
      }
      
      private function refreshView(param1:Date) : void
      {
         var _loc8_:Number = param1.getTime();
         var _loc6_:Number = TimeManager.Instance.Now().getTime();
         var _loc3_:Number = _loc8_ - _loc6_;
         _loc3_ = _loc3_ < 0?0:Number(_loc3_);
         var _loc2_:int = _loc3_ / 60000;
         var _loc4_:int = _loc3_ % 60000 / 1000;
         var _loc5_:String = _loc2_ < 10?"0" + _loc2_:_loc2_.toString();
         var _loc7_:String = _loc4_ < 10?"0" + _loc4_:_loc4_.toString();
         _txt.text = _recordTxt + _loc5_ + ":" + _loc7_;
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         refreshView(_endTime);
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
         }
         _timer = null;
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _txt = null;
         _recordTxt = null;
         _endTime = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
