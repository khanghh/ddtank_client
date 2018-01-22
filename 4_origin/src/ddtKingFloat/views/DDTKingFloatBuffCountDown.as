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
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DDTKingFloatBuffCountDown extends Sprite implements Disposeable
   {
      
      public static const END:String = "EscortBuffCountDownEnd";
       
      
      private var _bg:Bitmap;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _titleTxt:FilterFrameText;
      
      private var _endTime:Date;
      
      private var _timer:Timer;
      
      private var _type:int;
      
      private const colorList:Array = [16711680,1813759,59158,59158];
      
      public function DDTKingFloatBuffCountDown(param1:Date, param2:int, param3:int)
      {
         super();
         if(param2 == 3)
         {
            this.x = -87;
         }
         else
         {
            this.x = -183;
         }
         this.y = -101;
         _endTime = param1;
         _type = param2;
         _bg = ComponentFactory.Instance.creatBitmap("ddtKing.buffCountDownBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.game.buffTitleTxt");
         _titleTxt.text = LanguageMgr.GetTranslation("escort.game.buffTitleTxt" + _type);
         _titleTxt.textColor = colorList[_type - 1];
         _countDownTxt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.game.buffCountDownTxt");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_countDownTxt);
         refreshTxt(null);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",refreshTxt,false,0,true);
         _timer.start();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set endTime(param1:Date) : void
      {
         _endTime = param1;
         refreshTxt(null);
      }
      
      private function refreshTxt(param1:TimerEvent) : void
      {
         var _loc8_:Number = _endTime.getTime();
         var _loc6_:Number = TimeManager.Instance.Now().getTime();
         var _loc3_:Number = _loc8_ - _loc6_;
         _loc3_ = _loc3_ < 0?0:Number(_loc3_);
         var _loc2_:int = _loc3_ / 60000;
         var _loc4_:int = _loc3_ % 60000 / 1000;
         var _loc5_:String = _loc2_ < 10?"0" + _loc2_:_loc2_.toString();
         var _loc7_:String = _loc4_ < 10?"0" + _loc4_:_loc4_.toString();
         if(_countDownTxt)
         {
            _countDownTxt.text = _loc5_ + ":" + _loc7_;
            _countDownTxt.textColor = colorList[_type - 1];
         }
         if(_loc4_ <= 0)
         {
            dispatchEvent(new Event("EscortBuffCountDownEnd"));
         }
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",refreshTxt);
            _timer.stop();
         }
         _timer = null;
         _endTime = null;
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _titleTxt = null;
         _countDownTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
