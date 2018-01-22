package farm.viewx.helper
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.view.chat.ChatBasePanel;
   import farm.view.compose.event.SelectComposeItemEvent;
   import shop.view.ShopItemCell;
   
   public class FertilizerSelect extends ChatBasePanel implements Disposeable
   {
       
      
      private var _list:VBox;
      
      private var _bg:ScaleBitmapImage;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Vector.<HelperFerItem>;
      
      private var _result:ShopItemCell;
      
      public function FertilizerSelect()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _itemList = new Vector.<HelperFerItem>();
         _bg = ComponentFactory.Instance.creatComponentByStylename("farm.SeedListBg");
         _list = ComponentFactory.Instance.creatComponentByStylename("farm.helper.SeedList");
         _panel = ComponentFactory.Instance.creatComponentByStylename("farm.helper.Seedselect");
         _panel.setView(_list);
         addChild(_bg);
         addChild(_panel);
         setList();
      }
      
      private function setList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new HelperFerItem();
            _loc2_.info = _loc1_[_loc3_];
            _loc2_.addEventListener("selectFertilizer",__itemClick);
            _itemList.push(_loc2_);
            _list.addChild(_loc2_);
            _loc3_++;
         }
         _panel.invalidateViewport();
      }
      
      private function __itemClick(param1:SelectComposeItemEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new SelectComposeItemEvent("selectFertilizer",param1.data));
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].removeEventListener("selectSeed",__itemClick);
            ObjectUtils.disposeObject(_itemList[_loc1_]);
            _itemList[_loc1_] = null;
            _loc1_++;
         }
         _itemList = null;
      }
   }
}
