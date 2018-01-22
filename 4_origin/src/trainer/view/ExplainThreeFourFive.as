package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class ExplainThreeFourFive extends BaseExplainFrame
   {
       
      
      private var _bmpThree:Bitmap;
      
      private var _bmpFour:Bitmap;
      
      private var _bmpFive:Bitmap;
      
      private var _bmpNameBg1:Bitmap;
      
      private var _bmpNameBg2:Bitmap;
      
      private var _bmpNameBg3:Bitmap;
      
      private var _bmpTxtThree:Bitmap;
      
      private var _bmpTxtFour:Bitmap;
      
      private var _bmpTxtFive:Bitmap;
      
      private var _txtTip:FilterFrameText;
      
      private var _txtPs:FilterFrameText;
      
      public function ExplainThreeFourFive()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bmpThree = ComponentFactory.Instance.creatBitmap("asset.explain.threeUp");
         addChild(_bmpThree);
         _bmpFour = ComponentFactory.Instance.creatBitmap("asset.explain.four");
         addChild(_bmpFour);
         _bmpFour = ComponentFactory.Instance.creatBitmap("asset.explain.five");
         addChild(_bmpFour);
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("trainer.explain.posThreeUpBg");
         _bmpNameBg1 = ComponentFactory.Instance.creatBitmap("asset.explain.nameBg1");
         _bmpNameBg1.x = _loc1_.x;
         _bmpNameBg1.y = _loc1_.y;
         addChild(_bmpNameBg1);
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("trainer.explain.posFourBg");
         _bmpNameBg2 = ComponentFactory.Instance.creatBitmap("asset.explain.nameBg1");
         _bmpNameBg2.x = _loc3_.x;
         _bmpNameBg2.y = _loc3_.y;
         addChild(_bmpNameBg2);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("trainer.explain.posFiveBg");
         _bmpNameBg3 = ComponentFactory.Instance.creatBitmap("asset.explain.nameBg1");
         _bmpNameBg3.x = _loc2_.x;
         _bmpNameBg3.y = _loc2_.y;
         addChild(_bmpNameBg3);
         _bmpTxtThree = ComponentFactory.Instance.creatBitmap("asset.explain.bmpThreeUp");
         addChild(_bmpTxtThree);
         _bmpTxtFour = ComponentFactory.Instance.creatBitmap("asset.explain.bmpFour");
         addChild(_bmpTxtFour);
         _bmpTxtFive = ComponentFactory.Instance.creatBitmap("asset.explain.bmpFive");
         addChild(_bmpTxtFive);
         _txtTip = ComponentFactory.Instance.creat("trainer.explain.txtThreeFourFive");
         _txtTip.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainThreeFourFive.tip");
         addChild(_txtTip);
         _txtPs = ComponentFactory.Instance.creat("trainer.explain.txtPsThreeFourFive");
         _txtPs.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainThreeFourFive.ps");
         addChild(_txtPs);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,false,0);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bmpThree = null;
         _bmpFour = null;
         _bmpFive = null;
         _bmpNameBg1 = null;
         _bmpNameBg2 = null;
         _bmpNameBg3 = null;
         _bmpTxtThree = null;
         _bmpTxtFour = null;
         _bmpTxtFive = null;
         _txtTip = null;
         _txtPs = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
