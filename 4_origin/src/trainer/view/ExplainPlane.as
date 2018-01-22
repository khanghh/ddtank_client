package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   
   public class ExplainPlane extends BaseExplainFrame
   {
       
      
      private var _bmpPlane:Bitmap;
      
      private var _bmpNameBg:Bitmap;
      
      private var _bmpTxtPlane:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function ExplainPlane()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bmpPlane = ComponentFactory.Instance.creatBitmap("asset.explain.plane");
         addChild(_bmpPlane);
         _bmpNameBg = ComponentFactory.Instance.creatBitmap("asset.explain.nameBg");
         addChild(_bmpNameBg);
         _bmpTxtPlane = ComponentFactory.Instance.creatBitmap("asset.explain.bmpPlane");
         addChild(_bmpTxtPlane);
         _txt = ComponentFactory.Instance.creat("trainer.explain.txtPlane");
         _txt.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainPlane.explain");
         addChild(_txt);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,false,0);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bmpPlane = null;
         _bmpNameBg = null;
         _bmpTxtPlane = null;
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
