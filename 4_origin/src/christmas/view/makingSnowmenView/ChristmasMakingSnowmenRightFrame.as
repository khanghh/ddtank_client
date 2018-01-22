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
      
      public function set itemList(param1:Array) : void
      {
         this._itemList = param1;
      }
      
      public function get itemList() : Array
      {
         return this._itemList;
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 0;
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
         _loc3_ = 0;
         while(_loc3_ < SHOP_ITEM_NUM)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("christmas.view.christmasShopItem");
            itemList.push(_loc1_);
            itemList[_loc3_].initView(_loc3_);
            if(_loc3_ <= SHOP_ITEM_NUM - 2)
            {
               if(ChristmasCoreManager.instance.CanGetGift(_loc3_) && ChristmasCoreManager.instance.model.count >= ChristmasCoreManager.instance.model.snowPackNum[_loc3_])
               {
                  itemList[_loc3_].specialButton();
               }
            }
            else if(ChristmasCoreManager.instance.model.lastPacks > ChristmasCoreManager.instance.model.count)
            {
               itemList[_loc3_].grayButton();
            }
            else
            {
               itemList[_loc3_].specialButton();
               if(ChristmasCoreManager.instance.model.count - ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 2] >= ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] * (ChristmasCoreManager.instance.model.packsNumber + 1))
               {
                  itemList[_loc3_]._poorTxt.text = LanguageMgr.GetTranslation("christmas.poortTxt.OK.LG");
               }
               else
               {
                  _loc2_ = ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] - (ChristmasCoreManager.instance.model.count - (ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 2] + ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] * ChristmasCoreManager.instance.model.packsNumber));
                  itemList[_loc3_]._poorTxt.text = LanguageMgr.GetTranslation("christmas.list.poorTxt.LG",_loc2_);
               }
            }
            itemList[_loc3_].initText(ChristmasCoreController.instance.model.snowPackNum[_loc3_],_loc3_);
            itemList[_loc3_].y = (itemList[_loc3_].height + 1) * _loc3_;
            _shopItemArr.push(itemList[_loc3_]);
            _list.addChild(itemList[_loc3_]);
            _loc3_++;
         }
         _panel.setView(_list);
         addChild(_panel);
         _panel.invalidateViewport();
      }
      
      public function loadList() : void
      {
         setList(ChristmasCoreController.instance.model.myGiftData);
      }
      
      public function setList(param1:Vector.<ChristmasSystemItemsInfo>) : void
      {
         var _loc2_:int = 0;
         clearitems();
         _loc2_ = 0;
         while(_loc2_ < SHOP_ITEM_NUM)
         {
            if(param1)
            {
               if(_loc2_ < param1.length && param1[_loc2_])
               {
                  itemList[_loc2_].shopItemInfo = param1[_loc2_];
                  itemList[_loc2_].itemID = param1[_loc2_].TemplateID;
               }
               _loc2_++;
               continue;
            }
            break;
         }
      }
      
      private function initEvent() : void
      {
         ChristmasCoreManager.instance.addEventListener("christmas_packs",playerIsReceivePacks);
      }
      
      private function playerIsReceivePacks(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         ChristmasCoreController.instance.model.awardState = _loc3_.readInt();
         ChristmasCoreController.instance.model.packsNumber = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < SHOP_ITEM_NUM)
         {
            if(itemList[_loc5_].itemID == _loc2_ && _loc5_ < SHOP_ITEM_NUM - 1)
            {
               itemList[_loc5_].receiveOK();
               packsReceiveOK = true;
               break;
            }
            if(itemList[_loc5_].itemID == specialItemId && ChristmasCoreManager.instance.model.lastPacks <= ChristmasCoreManager.instance.model.count)
            {
               itemList[_loc5_].specialButton();
               if(ChristmasCoreManager.instance.model.count - ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 2] >= ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] * (ChristmasCoreManager.instance.model.packsNumber + 1))
               {
                  itemList[_loc5_]._poorTxt.text = LanguageMgr.GetTranslation("christmas.poortTxt.OK.LG");
               }
               else
               {
                  _loc4_ = ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] - (ChristmasCoreManager.instance.model.count - (ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 2] + ChristmasCoreManager.instance.model.snowPackNum[SHOP_ITEM_NUM - 1] * ChristmasCoreManager.instance.model.packsNumber));
                  itemList[_loc5_]._poorTxt.text = LanguageMgr.GetTranslation("christmas.list.poorTxt.LG",_loc4_);
               }
            }
            _loc5_++;
         }
      }
      
      private function clearitems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SHOP_ITEM_NUM)
         {
            itemList[_loc1_].shopItemInfo = null;
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         ChristmasCoreManager.instance.removeEventListener("christmas_packs",playerIsReceivePacks);
      }
      
      private function disposeItems() : void
      {
         var _loc1_:int = 0;
         if(itemList)
         {
            _loc1_ = 0;
            while(_loc1_ < itemList.length)
            {
               ObjectUtils.disposeObject(itemList[_loc1_]);
               itemList[_loc1_] = null;
               _loc1_++;
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
