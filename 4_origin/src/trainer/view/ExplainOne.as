package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   
   public class ExplainOne extends BaseExplainFrame
   {
       
      
      private var _bmpOne:Bitmap;
      
      private var _bmpNameBg:Bitmap;
      
      private var _bmpTxtOne:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function ExplainOne()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bmpOne = ComponentFactory.Instance.creatBitmap("asset.explain.one");
         addChild(_bmpOne);
         _bmpNameBg = ComponentFactory.Instance.creatBitmap("asset.explain.nameBg");
         addChild(_bmpNameBg);
         _bmpTxtOne = ComponentFactory.Instance.creatBitmap("asset.explain.txtOne");
         addChild(_bmpTxtOne);
         _txt = ComponentFactory.Instance.creat("trainer.explain.txtOneExplain");
         _txt.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainOne.explain");
         addChild(_txt);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,0);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bmpOne = null;
         _bmpNameBg = null;
         _bmpTxtOne = null;
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
