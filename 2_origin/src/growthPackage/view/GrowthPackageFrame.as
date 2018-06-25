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
         var i:int = 0;
         var item:* = null;
         titleText = LanguageMgr.GetTranslation("ddt.growthPackage.frameTitle");
         _bg = ComponentFactory.Instance.creatBitmap("assets.growthPackage.FrameBg");
         addToContent(_bg);
         _explainTxt = ComponentFactory.Instance.creatComponentByStylename("growthPackage.explainTxt.text");
         _explainTxt.text = LanguageMgr.GetTranslation("growthPackage.explainTxt.txt");
         addToContent(_explainTxt);
         _itemsSprite = new Sprite();
         addToContent(_itemsSprite);
         _items = new Vector.<GrowthPackageItem>();
         for(i = 0; i < GrowthPackageManager.indexMax; )
         {
            item = new GrowthPackageItem(i);
            item.y = i * 54;
            _itemsSprite.addChild(item);
            _items.push(item);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         GrowthPackageManager.instance.model.addEventListener("dataChange",__dataChange);
      }
      
      private function __dataChange(evt:GrowthPackageEvent) : void
      {
         updateItems();
      }
      
      private function updateItems() : void
      {
         var i:int = 0;
         if(_items)
         {
            for(i = 0; i < _items.length; )
            {
               updateItem(i);
               i++;
            }
         }
      }
      
      private function updateItem(index:int) : void
      {
         var tempItem:GrowthPackageItem = GrowthPackageItem(_items[index]);
         tempItem.updateState();
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
         var i:int = 0;
         var tempItem:* = null;
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_explainTxt);
         _explainTxt = null;
         if(_items)
         {
            for(i = 0; i < _items.length; )
            {
               tempItem = _items[i];
               ObjectUtils.disposeObject(tempItem);
               i++;
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
