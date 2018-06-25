package bagAndInfo.bag.ring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class RingSystemLevel extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _levelBg:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _mask:Shape;
      
      private var _exp:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      public function RingSystemLevel()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creat("asset.bagAndInfo.bag.RingSystemView.OpenBtn");
         _icon.x = 4;
         _icon.y = 2;
         addChild(_icon);
         _level = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.levelText");
         addChild(_level);
         creatProgress();
         _exp = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.expText");
         addChild(_exp);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.infoText");
         _infoText.text = LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.infoText1");
         addChild(_infoText);
      }
      
      private function creatProgress() : void
      {
         _progress = ComponentFactory.Instance.creat("asset.bagAndInfo.bag.RingSystem.levelProgress");
         addChild(_progress);
         _levelBg = ComponentFactory.Instance.creat("asset.bagAndInfo.bag.RingSystem.levelProgressBg");
         addChild(_levelBg);
         _mask = new Shape();
         _mask.graphics.beginFill(0,0.5);
         _mask.graphics.drawRect(_progress.x - _progress.width,_progress.y,_progress.width,_progress.height);
         _mask.graphics.endFill();
         addChild(_mask);
         _progress.mask = _mask;
      }
      
      public function setProgress(currentExp:int, level:int, exp:int) : void
      {
         _level.text = LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.levelText",level);
         _mask.x = _mask.x + currentExp * _progress.width / exp;
         _exp.text = currentExp + "/" + exp;
      }
      
      private function initEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_level);
         _level = null;
         ObjectUtils.disposeObject(_levelBg);
         _levelBg = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_exp);
         _exp = null;
         ObjectUtils.disposeObject(_infoText);
         _infoText = null;
      }
      
      private function removeEvent() : void
      {
      }
   }
}
