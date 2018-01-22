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
      
      public function IndianaProgressBar()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.indiana.progress.bg");
         _fg = ComponentFactory.Instance.creatBitmap("asset.indiana.progress.bar");
         _bar = ComponentFactory.Instance.creatBitmap("asset.indiana.progress.light");
         _mask = new Shape();
         _mask.graphics.beginFill(16777215);
         _mask.graphics.drawRect(0,0,_fg.width,_fg.height);
         _mask.graphics.endFill();
         _barWidth = _bg.width;
         _fg.mask = _mask;
         _txt = ComponentFactory.Instance.creatComponentByStylename("indiana.progress.Txt");
         _txt.text = LanguageMgr.GetTranslation("tank.view.effort.EffortPullDodnMenu.ACQUIRE");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("indiana.progress.value.Txt");
         addChild(_bg);
         addChild(_fg);
         addChild(_bar);
         addChild(_txt);
         addChild(_progressTxt);
         addChild(_mask);
         setProgress(0);
      }
      
      public function setProgress(param1:Number) : void
      {
         if(param1 <= 1)
         {
            _mask.width = param1 * _barWidth;
            _bar.x = _mask.width - _bar.width / 2;
            _progressTxt.text = (param1 * 100).toFixed(2) + "%";
         }
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _fg = null;
         _bg = null;
         _mask = null;
         _bar = null;
         _progressTxt = null;
      }
   }
}
