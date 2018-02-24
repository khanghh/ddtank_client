package store.view.exalt
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class StoreExaltProgressBar extends Sprite implements Disposeable
   {
       
      
      private var _title:FilterFrameText;
      
      private var _explain:FilterFrameText;
      
      private var _percentage:FilterFrameText;
      
      private var _progressBarBG:Bitmap;
      
      private var _progressBar:Bitmap;
      
      private var _mask:Shape;
      
      private var _currentProgress:Number;
      
      private var _maxWidth:int;
      
      private var _maxProgress:Number;
      
      public function StoreExaltProgressBar(){super();}
      
      private function init() : void{}
      
      public function progress(param1:Number, param2:Number) : void{}
      
      private function update() : void{}
      
      public function dispose() : void{}
   }
}
