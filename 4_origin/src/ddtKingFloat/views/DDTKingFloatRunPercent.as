package ddtKingFloat.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class DDTKingFloatRunPercent extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _recordTxt:String;
      
      public function DDTKingFloatRunPercent()
      {
         super();
         this.x = 445;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("ddtKing.countDownBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.countDownView.txt");
         _recordTxt = LanguageMgr.GetTranslation("escort.game.runPercentTxt");
         _txt.text = _recordTxt + "--";
         addChild(_bg);
         addChild(_txt);
      }
      
      public function refreshView(posX:int) : void
      {
         var tmpDis:int = 22780 - posX;
         tmpDis = tmpDis < 0?0:tmpDis;
         var tmp:int = Math.ceil(tmpDis / 22500 * 10);
         if(_txt)
         {
            _txt.text = _recordTxt + tmp * 10 + "%";
         }
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
