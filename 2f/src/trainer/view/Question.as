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
      
      public function Question(){super();}
      
      override public function dispose() : void{}
      
      private function initView() : void{}
   }
}
