package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class BrowserLeftStripAsset extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _filterTextImage:ScaleFrameImage;
      
      protected var _type_txt:GradientText;
      
      public function BrowserLeftStripAsset(param1:ScaleFrameImage){super();}
      
      public function set selectState(param1:Boolean) : void{}
      
      protected function initView() : void{}
      
      public function set bg(param1:ScaleFrameImage) : void{}
      
      public function set icon(param1:ScaleFrameImage) : void{}
      
      public function set type_txt(param1:GradientText) : void{}
      
      public function get bg() : ScaleFrameImage{return null;}
      
      public function get icon() : ScaleFrameImage{return null;}
      
      public function get type_txt() : GradientText{return null;}
      
      public function setFrameOnImage(param1:int) : void{}
      
      public function dispose() : void{}
      
      public function set type_text(param1:String) : void{}
      
      public function set type_text1(param1:String) : void{}
   }
}
