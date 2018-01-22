package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   
   public class ExplainTen extends BaseExplainFrame
   {
       
      
      private var _bmpTen:Bitmap;
      
      private var _bmpNameBg:Bitmap;
      
      private var _bmpTxtTen:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function ExplainTen()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bmpTen = ComponentFactory.Instance.creatBitmap("asset.explain.ten");
         addChild(_bmpTen);
         _bmpNameBg = ComponentFactory.Instance.creatBitmap("asset.explain.nameBg");
         addChild(_bmpNameBg);
         _bmpTxtTen = ComponentFactory.Instance.creatBitmap("asset.explain.txtTen");
         addChild(_bmpTxtTen);
         _txt = ComponentFactory.Instance.creat("trainer.explain.txtTenExplain");
         _txt.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainTen.explain");
         addChild(_txt);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,false,0);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bmpTen = null;
         _bmpNameBg = null;
         _bmpTxtTen = null;
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
