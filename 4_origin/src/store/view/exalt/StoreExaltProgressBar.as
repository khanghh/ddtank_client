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
      
      public function StoreExaltProgressBar()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _title = UICreatShortcut.creatTextAndAdd("ddt.store.view.exalt.StoreExaltProgressBar.title",LanguageMgr.GetTranslation("store.view.exalt.StoreExaltProgressBar.title"),this);
         _explain = UICreatShortcut.creatTextAndAdd("ddt.store.view.exalt.StoreExaltProgressBar.explain",LanguageMgr.GetTranslation("store.view.exalt.StoreExaltProgressBar.explain"),this);
         _progressBar = UICreatShortcut.creatAndAdd("asset.ddtstore.exalt.ProgressBar",this);
         _progressBarBG = UICreatShortcut.creatAndAdd("asset.ddtstore.exalt.ProgressBarBG",this);
         _percentage = UICreatShortcut.creatTextAndAdd("ddt.store.view.exalt.StoreExaltProgressBar.percentage","100%",this);
         _mask = new Shape();
         _mask.graphics.beginFill(16777215,1);
         _mask.graphics.drawRect(0,0,_progressBar.width,_progressBar.height);
         _mask.graphics.endFill();
         _mask.x = _progressBar.x;
         _mask.y = _progressBar.y;
         _progressBar.mask = _mask;
         addChild(_mask);
         _maxWidth = _progressBar.width;
      }
      
      public function progress(param1:Number, param2:Number) : void
      {
         _currentProgress = param1;
         _maxProgress = param2;
         update();
      }
      
      private function update() : void
      {
         if(_maxProgress != 0)
         {
            _mask.width = _maxWidth * (_currentProgress / _maxProgress);
         }
         else
         {
            _mask.width = 0;
         }
         _percentage.text = String(_currentProgress);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_explain);
         _explain = null;
         ObjectUtils.disposeObject(_percentage);
         _percentage = null;
         ObjectUtils.disposeObject(_progressBarBG);
         _progressBarBG = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
