package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class WinRate extends Sprite implements Disposeable
   {
       
      
      private var _win:int;
      
      private var _total:int;
      
      private var _bg:Bitmap;
      
      private var rate_txt:FilterFrameText;
      
      public function WinRate($win:int, $total:int)
      {
         super();
         _win = $win;
         _total = $total;
         init();
         setRate(_win,_total);
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.core.leveltip.WinRateBg");
         rate_txt = ComponentFactory.Instance.creat("core.WinRateTxt");
         addChild(_bg);
         addChild(rate_txt);
      }
      
      public function setRate($win:int, $total:int) : void
      {
         _win = $win;
         _total = $total;
         var rate:Number = _total > 0?_win / _total * 100:0;
         rate_txt.text = rate.toFixed(2) + "%";
      }
      
      public function dispose() : void
      {
         if(rate_txt)
         {
            ObjectUtils.disposeObject(rate_txt);
         }
         rate_txt = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
