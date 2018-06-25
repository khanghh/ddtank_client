package christmas.view.makingSnowmenView
{
   import christmas.ChristmasCoreController;
   import christmas.ChristmasCoreManager;
   import christmas.info.ChristmasSystemItemsInfo;
   import christmas.items.ChristmasListItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import road7th.comm.PackageIn;
   
   public class ChristmasMakingSnowmenRightFrame extends Sprite implements Disposeable
   {
      
      public static var specialItemId:int = 201156;
      
      public static var packsReceiveOK:Boolean;
       
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Array;
      
      private var SHOP_ITEM_NUM:int = 9;
      
      private var CURRENT_PAGE:int = 1;
      
      private var _shopItemArr:Array;
      
      public function ChristmasMakingSnowmenRightFrame()
      {
         super();
         initView();
         loadList();
         initEvent();
      }
      
      public function get shopItemArr() : Array
      {
         return _shopItemArr;
      }
      
      public function set itemList(value:Array) : void
      {
         this._itemList = value;
      }
      
      public function get itemList() : Array
      {
         return this._itemList;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         var poorNum:int = 0;
         _list = ComponentFactory.Instance.creatComponentByStylename("christmas.goodsListBox");
         _list.spacing = 5;
         _panel = ComponentFactory.Instance.creatComponentByStylename("christmas.right.scrollpanel");
         _panel.x = 286;
         _panel.y = 133;
         _panel.width = 400;
         _panel.height = 260;
         _shopItemArr = [];
         SHOP_ITEM_NUM = ChristmasCoreController.instance.model.packsLen;
         itemList = [];
         for(i = 0; i < SHOP_ITEM_NUM; )
         {
            item = ComponentFactory.Instance.creatCustomObject("christmas.view.christmasShopItem");
            itemList.push(item);
            itemList[i].initView(i);
            if(i <= SHOP_ITEM_NUM - 2)
            {
               if(ChristmasCoreManager.instance.CanGetGift(i) && ChristmasCoreManager.instance.model.count >= ChristmasCoreManager.instance.model.snowPackNum[i])
               {
                  itemList[i].specialButton();
               }
            }
            else if(ChristmasCoreManager.instance.model.lastPacks > ChristmasCoreManager.instance.model.count)
            {
               itemList[i].grayButton();
            }
            else
            {
               itemList[i].specialButton();
               if(ChristmasCoreManager.instance.model.count - ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 2] >= ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] * (ChristmasCoreManager.instance.model.packsNumber + 1))
               {
                  itemList[i]._poorTxt.text = LanguageMgr.GetTranslation("christmas.poortTxt.OK.LG");
               }
               else
               {
                  poorNum = ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] - (ChristmasCoreManager.instance.model.count - (ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 2] + ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] * ChristmasCoreManager.instance.model.packsNumber));
                  itemList[i]._poorTxt.text = LanguageMgr.GetTranslation("christmas.list.poorTxt.LG",poorNum);
               }
            }
            itemList[i].initText(ChristmasCoreController.instance.model.snowPackNum[i],i);
            itemList[i].y = (itemList[i].height + 1) * i;
            _shopItemArr.push(itemList[i]);
            _list.addChild(itemList[i]);
            i++;
         }
         _panel.setView(_list);
         addChild(_panel);
         _panel.invalidateViewport();
      }
      
      public function loadList() : void
      {
         setList(ChristmasCoreController.instance.model.myGiftData);
      }
      
      public function setList(list:Vector.<ChristmasSystemItemsInfo>) : void
      {
         var i:int = 0;
         clearitems();
         for(i = 0; i < SHOP_ITEM_NUM; )
         {
            if(list)
            {
               if(i < list.length && list[i])
               {
                  itemList[i].shopItemInfo = list[i];
                  itemList[i].itemID = list[i].TemplateID;
               }
               i++;
               continue;
            }
            break;
         }
      }
      
      private function initEvent() : void
      {
         ChristmasCoreManager.instance.addEventListener("christmas_packs",playerIsReceivePacks);
      }
      
      private function playerIsReceivePacks(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var poorNum:int = 0;
         var pkg:PackageIn = event.pkg;
         ChristmasCoreController.instance.model.awardState = pkg.readInt();
         ChristmasCoreController.instance.model.packsNumber = pkg.readInt();
         var listItemId:int = pkg.readInt();
         for(i = 0; i < SHOP_ITEM_NUM; )
         {
            if(itemList[i].itemID == listItemId && i < SHOP_ITEM_NUM - 1)
            {
               itemList[i].receiveOK();
               packsReceiveOK = true;
               break;
            }
            if(itemList[i].itemID == specialItemId && ChristmasCoreManager.instance.model.lastPacks <= ChristmasCoreManager.instance.model.count)
            {
               itemList[i].specialButton();
               if(ChristmasCoreManager.instance.model.count - ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 2] >= ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] * (ChristmasCoreManager.instance.model.packsNumber + 1))
               {
                  itemList[i]._poorTxt.text = LanguageMgr.GetTranslation("christmas.poortTxt.OK.LG");
               }
               else
               {
                  poorNum = ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] - (ChristmasCoreManager.instance.model.count - (ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 2] + ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] * ChristmasCoreManager.instance.model.packsNumber));
                  itemList[i]._poorTxt.text = LanguageMgr.GetTranslation("christmas.list.poorTxt.LG",poorNum);
               }
            }
            i++;
         }
      }
      
      private function clearitems() : void
      {
         var i:int = 0;
         for(i = 0; i < SHOP_ITEM_NUM; )
         {
            itemList[i].shopItemInfo = null;
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         ChristmasCoreManager.instance.removeEventListener("christmas_packs",playerIsReceivePacks);
      }
      
      private function disposeItems() : void
      {
         var i:int = 0;
         if(itemList)
         {
            for(i = 0; i < itemList.length; )
            {
               ObjectUtils.disposeObject(itemList[i]);
               itemList[i] = null;
               i++;
            }
            itemList = null;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         disposeItems();
         ObjectUtils.disposeAllChildren(_list);
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeAllChildren(_panel);
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
