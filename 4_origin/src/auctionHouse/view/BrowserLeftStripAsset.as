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
      
      public function BrowserLeftStripAsset(param1:ScaleFrameImage)
      {
         super();
         _filterTextImage = param1;
         initView();
      }
      
      public function set selectState(param1:Boolean) : void
      {
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.BrowseLeftStripBG");
         addChild(_bg);
         _icon = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.BrowseLeftStripIcon");
         _type_txt = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.BrowseLeftStripTextFilt");
         addChild(_type_txt);
         addChild(_filterTextImage);
      }
      
      public function set bg(param1:ScaleFrameImage) : void
      {
         _bg = param1;
      }
      
      public function set icon(param1:ScaleFrameImage) : void
      {
         _icon = param1;
      }
      
      public function set type_txt(param1:GradientText) : void
      {
         _type_txt = param1;
      }
      
      public function get bg() : ScaleFrameImage
      {
         return _bg;
      }
      
      public function get icon() : ScaleFrameImage
      {
         return _icon;
      }
      
      public function get type_txt() : GradientText
      {
         return _type_txt;
      }
      
      public function setFrameOnImage(param1:int) : void
      {
         if(_filterTextImage)
         {
            _filterTextImage.setFrame(param1);
         }
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_type_txt)
         {
            ObjectUtils.disposeObject(_type_txt);
         }
         _type_txt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set type_text(param1:String) : void
      {
      }
      
      public function set type_text1(param1:String) : void
      {
      }
   }
}
