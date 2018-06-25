package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class ExplainTwoTwenty extends BaseExplainFrame
   {
       
      
      private var _bmpLine:Bitmap;
      
      private var _bmpTwo:Bitmap;
      
      private var _bmpTwenty:Bitmap;
      
      private var _bmpNameBgTwo:Bitmap;
      
      private var _bmpNameBgTwenty:Bitmap;
      
      private var _bmpTxtTwo:Bitmap;
      
      private var _bmpTxtTwenty:Bitmap;
      
      private var _txtTwo:FilterFrameText;
      
      private var _txtTwenty:FilterFrameText;
      
      private var _txtPs:FilterFrameText;
      
      public function ExplainTwoTwenty()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bmpLine = ComponentFactory.Instance.creatBitmap("asset.explain.line");
         addChild(_bmpLine);
         _bmpTwo = ComponentFactory.Instance.creatBitmap("asset.explain.two");
         addChild(_bmpTwo);
         _bmpTwenty = ComponentFactory.Instance.creatBitmap("asset.explain.twenty");
         addChild(_bmpTwenty);
         var posTwo:Point = ComponentFactory.Instance.creatCustomObject("trainer.explain.posThreeBg");
         _bmpNameBgTwo = ComponentFactory.Instance.creatBitmap("asset.explain.nameBgSmall");
         _bmpNameBgTwo.x = posTwo.x;
         _bmpNameBgTwo.y = posTwo.y;
         addChild(_bmpNameBgTwo);
         var posTwenty:Point = ComponentFactory.Instance.creatCustomObject("trainer.explain.posPowerBg");
         _bmpNameBgTwenty = ComponentFactory.Instance.creatBitmap("asset.explain.nameBgSmall");
         _bmpNameBgTwenty.x = posTwenty.x;
         _bmpNameBgTwenty.y = posTwenty.y;
         addChild(_bmpNameBgTwenty);
         _bmpTxtTwo = ComponentFactory.Instance.creatBitmap("asset.explain.bmpTwo");
         addChild(_bmpTxtTwo);
         _bmpTxtTwenty = ComponentFactory.Instance.creatBitmap("asset.explain.bmpTwenty");
         addChild(_bmpTxtTwenty);
         _txtTwo = ComponentFactory.Instance.creat("trainer.explain.txtThree");
         _txtTwo.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainTwoTwenty.two");
         addChild(_txtTwo);
         _txtTwenty = ComponentFactory.Instance.creat("trainer.explain.txtPower");
         _txtTwenty.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainTwoTwenty.twenty");
         addChild(_txtTwenty);
         _txtPs = ComponentFactory.Instance.creat("trainer.explain.txtPsPowerThree");
         _txtPs.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainTwoTwenty.ps");
         addChild(_txtPs);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,false,0);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bmpLine = null;
         _bmpTwo = null;
         _bmpTwenty = null;
         _bmpNameBgTwo = null;
         _bmpNameBgTwenty = null;
         _bmpTxtTwo = null;
         _bmpTxtTwenty = null;
         _txtTwo = null;
         _txtTwenty = null;
         _txtPs = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
