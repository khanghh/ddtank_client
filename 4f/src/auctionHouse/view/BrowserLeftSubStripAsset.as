package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BrowserLeftSubStripAsset extends BrowserLeftStripAsset
   {
       
      
      private var _type_text:FilterFrameText;
      
      private var _type_text1:FilterFrameText;
      
      private var _img:ScaleFrameImage;
      
      private var menubg:ScaleUpDownImage;
      
      public function BrowserLeftSubStripAsset(){super(null);}
      
      override protected function initView() : void{}
      
      override public function set selectState(param1:Boolean) : void{}
      
      override public function set type_txt(param1:GradientText) : void{}
      
      override public function get type_txt() : GradientText{return null;}
      
      override public function set type_text(param1:String) : void{}
      
      override public function dispose() : void{}
   }
}
