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
      
      public function BrowserLeftSubStripAsset()
      {
         super(_img);
      }
      
      override protected function initView() : void
      {
         menubg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtauctionHouse.menuBg");
         addChild(menubg);
         bg = ComponentFactory.Instance.creat("auctionHouse.BrowseLeftSubStripBG");
         addChild(bg);
         _type_text = ComponentFactory.Instance.creat("auctionHouse.BrowseLeftSubStripText");
         _type_text1 = ComponentFactory.Instance.creat("auctionHouse.BrowseLeftSubStripText1");
         _type_txt = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.BrowseLeftStripTextFilt");
         addChild(_type_text);
         _type_text1.visible = false;
         addChild(_type_text1);
         icon = null;
      }
      
      override public function set selectState(param1:Boolean) : void
      {
         if(param1)
         {
            _type_text.visible = false;
            _type_text1.visible = true;
         }
         else
         {
            _type_text.visible = true;
            _type_text1.visible = false;
         }
      }
      
      override public function set type_txt(param1:GradientText) : void
      {
         _type_txt = param1;
         _type_text.text = _type_txt.text;
         _type_text1.text = _type_txt.text;
      }
      
      override public function get type_txt() : GradientText
      {
         return _type_txt;
      }
      
      override public function set type_text(param1:String) : void
      {
         _type_text.text = param1;
         _type_text1.text = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_type_text)
         {
            ObjectUtils.disposeObject(_type_text);
         }
         _type_text = null;
         if(_type_text1)
         {
            ObjectUtils.disposeObject(_type_text1);
         }
         _type_text1 = null;
         if(menubg)
         {
            ObjectUtils.disposeObject(menubg);
         }
         menubg = null;
      }
   }
}
