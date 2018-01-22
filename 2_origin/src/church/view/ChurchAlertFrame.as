package church.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   
   public class ChurchAlertFrame extends BaseAlerFrame
   {
       
      
      private var _txt:FilterFrameText;
      
      public function ChurchAlertFrame()
      {
         super();
         var _loc1_:AlertInfo = new AlertInfo("离婚支付请求",LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"));
         info = _loc1_;
         _txt = ComponentFactory.Instance.creatComponentByStylename("FrameTitleTextStyle");
         _txt.autoSize = "none";
         _txt.width = 300;
         _txt.height = 150;
         _txt.x = 48;
         _txt.y = 48;
         _txt.wordWrap = true;
         _txt.multiline = true;
         addToContent(_txt);
      }
      
      public function setTxt(param1:String) : void
      {
         _txt.text = param1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         super.dispose();
      }
   }
}
