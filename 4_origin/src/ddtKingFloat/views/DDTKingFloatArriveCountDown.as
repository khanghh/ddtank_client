package ddtKingFloat.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class DDTKingFloatArriveCountDown extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _recordTxt:String;
      
      public function DDTKingFloatArriveCountDown()
      {
         super();
         this.x = 445;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("ddtKing.countDownBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.countDownView.txt");
         _recordTxt = LanguageMgr.GetTranslation("drgnBoat.arriveCountDownTxt");
         _txt.text = _recordTxt + "--";
         addChild(_bg);
         addChild(_txt);
      }
      
      public function refreshView(posX:int, carSpeed:int) : void
      {
         var tmpDis:int = 33600 + 280 - posX;
         tmpDis = tmpDis < 0?0:tmpDis;
         var differ:Number = tmpDis / carSpeed / 25;
         differ = differ < 0?0:Number(differ);
         var minute:int = differ / 60;
         var second:int = differ % 60;
         var minStr:String = minute < 10?"0" + minute:minute.toString();
         var secStr:String = second < 10?"0" + second:second.toString();
         _txt.text = _recordTxt + minStr + ":" + secStr;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _txt = null;
         _recordTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
