package ddtmatch.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   
   public class DDTMatchBuyFrame extends Frame
   {
       
      
      private var _inputBg:Scale9CornerImage;
      
      private var _confirm:TextButton;
      
      private var _cancel:TextButton;
      
      public function DDTMatchBuyFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.inputTxt");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.ok");
         _confirm.text = LanguageMgr.GetTranslation("ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.cancel");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         addToContent(_confirm);
         addToContent(_cancel);
         addToContent(_inputBg);
      }
      
      override public function dispose() : void
      {
         if(_confirm)
         {
            ObjectUtils.disposeObject(_confirm);
         }
         _confirm = null;
         if(_cancel)
         {
            ObjectUtils.disposeObject(_cancel);
         }
         _cancel = null;
         if(_inputBg)
         {
            ObjectUtils.disposeObject(_inputBg);
         }
         _inputBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
