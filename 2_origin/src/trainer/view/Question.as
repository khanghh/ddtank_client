package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class Question extends Frame
   {
       
      
      protected var imgTxtBg:ScaleBitmapImage;
      
      protected var txtTitle:FilterFrameText;
      
      protected var txtTip:FilterFrameText;
      
      protected var txtAward:FilterFrameText;
      
      protected var vbox:VBox;
      
      private var _imgBg:ScaleBitmapImage;
      
      public function Question()
      {
         super();
         initView();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _imgBg = null;
         imgTxtBg = null;
         txtTip = null;
         txtAward = null;
         txtTitle = null;
         vbox = null;
         super.dispose();
      }
      
      private function initView() : void
      {
         _imgBg = ComponentFactory.Instance.creat("trainer.question.bg");
         addToContent(_imgBg);
         imgTxtBg = ComponentFactory.Instance.creat("trainer.question.txtBg");
         addToContent(imgTxtBg);
         txtTip = ComponentFactory.Instance.creat("trainer.question.tip");
         addToContent(txtTip);
         txtAward = ComponentFactory.Instance.creat("trainer.question.award");
         addToContent(txtAward);
         txtTitle = ComponentFactory.Instance.creat("trainer.question.title");
         addToContent(txtTitle);
         vbox = ComponentFactory.Instance.creat("trainer.question.vbox");
         addToContent(vbox);
      }
   }
}
