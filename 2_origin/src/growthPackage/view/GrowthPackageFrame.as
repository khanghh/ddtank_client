package growthPackage.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import growthPackage.GrowthPackageManager;
   import growthPackage.event.GrowthPackageEvent;
   
   public class GrowthPackageFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _explainTxt:FilterFrameText;
      
      private var _itemsSprite:Sprite;
      
      private var _items:Vector.<GrowthPackageItem>;
      
      public function GrowthPackageFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("ddt.growthPackage.frameTitle");
         _bg = ComponentFactory.Instance.creatBitmap("assets.growthPackage.FrameBg");
         addToContent(_bg);
         _explainTxt = ComponentFactory.Instance.creatComponentByStylename("growthPackage.explainTxt.text");
         _explainTxt.text = LanguageMgr.GetTranslation("growthPackage.explainTxt.txt");
         addToContent(_explainTxt);
         _itemsSprite = new Sprite();
         addToContent(_itemsSprite);
         _items = new Vector.<GrowthPackageItem>();
         _loc2_ = 0;
         while(_loc2_ < GrowthPackageManager.indexMax)
         {
            _loc1_ = new GrowthPackageItem(_loc2_);
            _loc1_.y = _loc2_ * 54;
            _itemsSprite.addChild(_loc1_);
            _items.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         GrowthPackageManager.instance.model.addEventListener("dataChange",__dataChange);
      }
      
      private function __dataChange(param1:GrowthPackageEvent) : void
      {
         updateItems();
      }
      
      private function updateItems() : void
      {
         var _loc1_:int = 0;
         if(_items)
         {
            _loc1_ = 0;
            while(_loc1_ < _items.length)
            {
               updateItem(_loc1_);
               _loc1_++;
            }
         }
      }
      
      private function updateItem(param1:int) : void
      {
         var _loc2_:GrowthPackageItem = GrowthPackageItem(_items[param1]);
         _loc2_.updateState();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         GrowthPackageManager.instance.model.removeEventListener("dataChange",__dataChange);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_explainTxt);
         _explainTxt = null;
         if(_items)
         {
            _loc2_ = 0;
            while(_loc2_ < _items.length)
            {
               _loc1_ = _items[_loc2_];
               ObjectUtils.disposeObject(_loc1_);
               _loc2_++;
            }
            _items = null;
         }
         if(_itemsSprite)
         {
            ObjectUtils.disposeAllChildren(_itemsSprite);
            ObjectUtils.disposeObject(_itemsSprite);
            _itemsSprite = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
