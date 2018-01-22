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
      
      public function WinRate(param1:int, param2:int)
      {
         super();
         _win = param1;
         _total = param2;
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
      
      public function setRate(param1:int, param2:int) : void
      {
         _win = param1;
         _total = param2;
         var _loc3_:Number = _total > 0?_win / _total * 100:0;
         rate_txt.text = _loc3_.toFixed(2) + "%";
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
