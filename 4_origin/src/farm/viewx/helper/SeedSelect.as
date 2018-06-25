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
   import farm.modelx.FieldVO;
   import farm.view.compose.event.SelectComposeItemEvent;
   import shop.view.ShopItemCell;
   
   public class SeedSelect extends ChatBasePanel implements Disposeable
   {
       
      
      private var _list:VBox;
      
      private var _bg:ScaleBitmapImage;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Vector.<HelperSetItem>;
      
      private var _filedVO:Vector.<FieldVO>;
      
      private var _result:ShopItemCell;
      
      private var _seedId:int;
      
      public function SeedSelect()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _itemList = new Vector.<HelperSetItem>();
         _filedVO = new Vector.<FieldVO>();
         _bg = ComponentFactory.Instance.creatComponentByStylename("farm.SeedListBg");
         _list = ComponentFactory.Instance.creatComponentByStylename("farm.helper.SeedList");
         _panel = ComponentFactory.Instance.creatComponentByStylename("farm.helper.Seedselect");
         _panel.height = 100;
         _panel.setView(_list);
         addChild(_bg);
         addChild(_panel);
         setList();
      }
      
      public function set result(value:ShopItemCell) : void
      {
         _result = value;
      }
      
      public function get result() : ShopItemCell
      {
         return _result;
      }
      
      private function setList() : void
      {
         var i:int = 0;
         var item:* = null;
         var infoList:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         for(i = 0; i < infoList.length; )
         {
            item = new HelperSetItem();
            item.info = infoList[i];
            item.addEventListener("selectSeed",__itemClick);
            _itemList.push(item);
            _list.addChild(item);
            i++;
         }
         _panel.invalidateViewport();
      }
      
      private function __itemClick(event:SelectComposeItemEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new SelectComposeItemEvent("selectSeed",event.data));
      }
      
      public function dispose() : void
      {
         var i:int = 0;
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
         while(i < _itemList.length)
         {
            _itemList[i].removeEventListener("selectSeed",__itemClick);
            ObjectUtils.disposeObject(_itemList[i]);
            _itemList[i] = null;
            i++;
         }
         _itemList = null;
      }
   }
}
