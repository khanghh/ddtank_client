package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class ExplainPowerThree extends BaseExplainFrame
   {
       
      
      private var _bmpLine:Bitmap;
      
      private var _bmpThree:Bitmap;
      
      private var _bmpPower:Bitmap;
      
      private var _bmpNameBgThree:Bitmap;
      
      private var _bmpNameBgPower:Bitmap;
      
      private var _bmpTxtThere:Bitmap;
      
      private var _bmpTxtPower:Bitmap;
      
      private var _txtThree:FilterFrameText;
      
      private var _txtPower:FilterFrameText;
      
      private var _txtPs:FilterFrameText;
      
      public function ExplainPowerThree()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bmpLine = ComponentFactory.Instance.creatBitmap("asset.explain.line");
         addChild(_bmpLine);
         _bmpThree = ComponentFactory.Instance.creatBitmap("asset.explain.three");
         addChild(_bmpThree);
         _bmpPower = ComponentFactory.Instance.creatBitmap("asset.explain.power");
         addChild(_bmpPower);
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("trainer.explain.posThreeBg");
         _bmpNameBgThree = ComponentFactory.Instance.creatBitmap("asset.explain.nameBgSmall");
         _bmpNameBgThree.x = _loc1_.x;
         _bmpNameBgThree.y = _loc1_.y;
         addChild(_bmpNameBgThree);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("trainer.explain.posPowerBg");
         _bmpNameBgPower = ComponentFactory.Instance.creatBitmap("asset.explain.nameBgSmall");
         _bmpNameBgPower.x = _loc2_.x;
         _bmpNameBgPower.y = _loc2_.y;
         addChild(_bmpNameBgPower);
         _bmpTxtThere = ComponentFactory.Instance.creatBitmap("asset.explain.bmpThree");
         addChild(_bmpTxtThere);
         _bmpTxtPower = ComponentFactory.Instance.creatBitmap("asset.explain.bmpPower");
         addChild(_bmpTxtPower);
         _txtThree = ComponentFactory.Instance.creat("trainer.explain.txtThree");
         _txtThree.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainPowerThree.three");
         addChild(_txtThree);
         _txtPower = ComponentFactory.Instance.creat("trainer.explain.txtPower");
         _txtPower.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainPowerThree.power");
         addChild(_txtPower);
         _txtPs = ComponentFactory.Instance.creat("trainer.explain.txtPsPowerThree");
         _txtPs.text = LanguageMgr.GetTranslation("ddt.trainer.view.ExplainPowerThree.ps");
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
         _bmpThree = null;
         _bmpPower = null;
         _bmpNameBgThree = null;
         _bmpNameBgPower = null;
         _bmpTxtThere = null;
         _bmpTxtPower = null;
         _txtThree = null;
         _txtPower = null;
         _txtPs = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
