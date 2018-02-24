package Indiana
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class IndianaProgressBar extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _fg:Bitmap;
      
      private var _mask:Shape;
      
      private var _bar:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _barWidth:int;
      
      public function IndianaProgressBar(){super();}
      
      private function initView() : void{}
      
      public function setProgress(param1:Number) : void{}
      
      public function dispose() : void{}
   }
}
