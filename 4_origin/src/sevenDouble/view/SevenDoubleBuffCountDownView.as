package sevenDouble.view
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
   
   public class SevenDoubleBuffCountDownView extends Sprite implements Disposeable
   {
      
      public static const END:String = "SevenDoubleBuffCountDownEnd";
       
      
      private var _bg:Bitmap;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _titleTxt:FilterFrameText;
      
      private var _endTime:Date;
      
      private var _timer:Timer;
      
      private var _type:int;
      
      private const colorList:Array = [16711680,1813759,59158];
      
      public function SevenDoubleBuffCountDownView(endTime:Date, type:int, index:int)
      {
         super();
         if(type == 3)
         {
            this.x = -97;
         }
         else
         {
            this.x = -213;
         }
         this.y = -138;
         _endTime = endTime;
         _type = type;
         _bg = ComponentFactory.Instance.creatBitmap("asset.sevenDouble.buffCountDownBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.game.buffTitleTxt");
         _titleTxt.text = LanguageMgr.GetTranslation("sevenDouble.game.buffTitleTxt" + _type);
         _titleTxt.textColor = colorList[_type - 1];
         _countDownTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.game.buffCountDownTxt");
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
      
      public function set endTime(value:Date) : void
      {
         _endTime = value;
         refreshTxt(null);
      }
      
      private function refreshTxt(event:TimerEvent) : void
      {
         var endTimestamp:Number = _endTime.getTime();
         var nowTimestamp:Number = TimeManager.Instance.Now().getTime();
         var differ:Number = endTimestamp - nowTimestamp;
         differ = differ < 0?0:Number(differ);
         var minute:int = differ / 60000;
         var second:int = differ % 60000 / 1000;
         var minStr:String = minute < 10?"0" + minute:minute.toString();
         var secStr:String = second < 10?"0" + second:second.toString();
         _countDownTxt.text = minStr + ":" + secStr;
         _countDownTxt.textColor = colorList[_type - 1];
         if(second <= 0)
         {
            dispatchEvent(new Event("SevenDoubleBuffCountDownEnd"));
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
