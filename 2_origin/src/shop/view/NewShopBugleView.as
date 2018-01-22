package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class NewShopBugleView extends Sprite implements Disposeable
   {
      
      public static const BUGLE:uint = 3;
      
      public static const GOLD:uint = 0;
      
      public static const TEXP:uint = 6;
      
      public static const DONT_BUY_ANYTHING:String = "dontBuyAnything";
       
      
      protected var _frame:BaseAlerFrame;
      
      protected var _info:ShopItemInfo;
      
      protected var _itemContainer:HBox;
      
      protected var _itemGroup:SelectedButtonGroup;
      
      protected var _type:int;
      
      protected var _buyFrom:int;
      
      private var _text1:FilterFrameText;
      
      private var _text2:FilterFrameText;
      
      private var _textBg:Image;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      protected var _isBand:Boolean;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      public function NewShopBugleView(param1:int)
      {
         super();
         _type = param1;
         init();
         ChatManager.Instance.focusFuncEnabled = false;
         if(_info)
         {
            LayerManager.Instance.addToLayer(this,2,true,2);
         }
         _textBg = ComponentFactory.Instance.creat("asset.medicineQuickBugTextBg");
         addChild(_textBg);
         _text1 = ComponentFactory.Instance.creat("asset.medicineQuickBugText1");
         addChild(_text1);
         _text1.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         _text2 = ComponentFactory.Instance.creat("asset.medicineQuickBugText2");
         addChild(_text2);
         if(_isBand)
         {
            _text2.text = (_itemContainer.getChildAt(0) as NewShopBugViewItem).money + LanguageMgr.GetTranslation("ddtMoney");
         }
         else
         {
            _text2.text = (_itemContainer.getChildAt(0) as NewShopBugViewItem).money + LanguageMgr.GetTranslation("money");
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         StageReferance.stage.removeEventListener("keyDown",__onKeyDownd);
         if(_type == 40003)
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandBag(true);
         }
         if(_itemContainer)
         {
            while(_itemContainer.numChildren > 0)
            {
               _loc1_ = _itemContainer.getChildAt(0) as NewShopBugViewItem;
               _loc1_.removeEventListener("click",__click);
               _loc1_.dispose();
               _loc1_ = null;
            }
            _itemContainer.dispose();
            _itemContainer = null;
         }
         if(_textBg)
         {
            _textBg.dispose();
         }
         _textBg = null;
         if(_text1)
         {
            ObjectUtils.disposeObject(_text1);
         }
         _text1 = null;
         if(_text2)
         {
            ObjectUtils.disposeObject(_text2);
         }
         _text2 = null;
         _frame.dispose();
         clearAllItem();
         _frame = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         ChatManager.Instance.focusFuncEnabled = true;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get info() : ShopItemInfo
      {
         return _info;
      }
      
      protected function __onKeyDownd(param1:KeyboardEvent) : void
      {
         var _loc3_:int = _itemGroup.selectIndex;
         var _loc2_:int = _itemContainer.numChildren;
         if(param1.keyCode == 37)
         {
            if(_loc3_ == 0)
            {
               §§push(0);
            }
            else
            {
               _loc3_--;
               §§push(_loc3_);
            }
            _loc3_ = §§pop();
         }
         else if(param1.keyCode == 39)
         {
            if(_loc3_ == _loc2_ - 1)
            {
               §§push(_loc2_ - 1);
            }
            else
            {
               _loc3_++;
               §§push(_loc3_);
            }
            _loc3_ = §§pop();
         }
         else
         {
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            return;
         }
         if(_itemGroup.selectIndex != _loc3_)
         {
            SoundManager.instance.play("008");
            _itemGroup.selectIndex = _loc3_;
         }
         if(_isBand)
         {
            _text2.text = info.getItemPrice(_loc3_ + 1).bothMoneyValue + LanguageMgr.GetTranslation("ddtMoney");
         }
         else
         {
            _text2.text = info.getItemPrice(_loc3_ + 1).bothMoneyValue + LanguageMgr.GetTranslation("money");
         }
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispatchEvent(new Event("DONT_BUY_ANYTHING"));
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               _loc2_ = _itemContainer.getChildAt(_itemGroup.selectIndex) as NewShopBugViewItem;
               CheckMoneyUtils.instance.checkMoney(_isBand,_loc2_.money,onCheckComplete,onCheckCancel);
               break;
         }
      }
      
      protected function onCheckComplete() : void
      {
         var _loc1_:NewShopBugViewItem = _itemContainer.getChildAt(_itemGroup.selectIndex) as NewShopBugViewItem;
         SocketManager.Instance.out.sendBuyGoods([_info.GoodsID],[_loc1_.type],[""],[0],[false],[""],_buyFrom,null,[CheckMoneyUtils.instance.isBind]);
         dispose();
      }
      
      protected function onCheckCancel() : void
      {
         dispose();
      }
      
      protected function addItem(param1:ShopItemInfo, param2:int) : void
      {
         var _loc5_:Shape = new Shape();
         _loc5_.graphics.beginFill(16777215,0);
         _loc5_.graphics.drawRect(0,0,70,70);
         _loc5_.graphics.endFill();
         var _loc4_:ShopItemCell = CellFactory.instance.createShopItemCell(_loc5_,param1.TemplateInfo) as ShopItemCell;
         PositionUtils.setPos(_loc4_,"ddtshop.BugleViewItemCellPos");
         var _loc3_:NewShopBugViewItem = new NewShopBugViewItem(param2,param1.getTimeToString(param2),param1.getItemPrice(param2).bothMoneyValue,_loc4_);
         _loc3_.addEventListener("click",__click);
         _itemContainer.addChild(_loc3_);
         _itemGroup.addSelectItem(_loc3_);
      }
      
      protected function __click(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _itemGroup.selectIndex = _itemContainer.getChildIndex(param1.currentTarget as NewShopBugViewItem);
         if(_isBand)
         {
            _text2.text = (_itemContainer.getChildAt(_itemGroup.selectIndex) as NewShopBugViewItem).money + LanguageMgr.GetTranslation("ddtMoney");
         }
         else
         {
            _text2.text = (_itemContainer.getChildAt(_itemGroup.selectIndex) as NewShopBugViewItem).money + LanguageMgr.GetTranslation("money");
         }
      }
      
      protected function addItems() : void
      {
         var _loc1_:int = 0;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         if(_type == 11102)
         {
            _loc1_ = 11102;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.bigbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11101)
         {
            _loc1_ = 11101;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.smallbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11100)
         {
            _loc1_ = 11100;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.crossbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11456)
         {
            _loc1_ = 11456;
            _frame.titleText = LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy");
            _buyFrom = 0;
         }
         else if(_type == 40003)
         {
            _loc1_ = 40003;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.texpQuickBuy");
            _buyFrom = 6;
         }
         else if(_type == 40006)
         {
            _loc1_ = 40006;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.texpQuickBuy");
            _buyFrom = 6;
         }
         _info = ShopManager.Instance.getMoneyShopItemByTemplateID(_loc1_);
         if(_info)
         {
            _loc4_ = _info.getItemPrice(1).IsValid;
            _loc3_ = _info.getItemPrice(2).IsValid;
            _loc2_ = _info.getItemPrice(3).IsValid;
            if(_info.getItemPrice(1).IsValid)
            {
               addItem(_info,1);
            }
            if(_info.getItemPrice(2).IsValid)
            {
               addItem(_info,2);
            }
            if(_info.getItemPrice(3).IsValid)
            {
               addItem(_info,3);
            }
         }
      }
      
      private function clearAllItem() : void
      {
         var _loc1_:* = null;
         if(!_itemContainer)
         {
            return;
         }
         while(_itemContainer.numChildren > 0)
         {
            _loc1_ = _itemContainer.getChildAt(0) as NewShopBugViewItem;
            _loc1_.removeEventListener("click",__click);
            _loc1_.dispose();
            _loc1_ = null;
         }
      }
      
      private function init() : void
      {
         _itemGroup = new SelectedButtonGroup();
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddtshop.newBugleFrame");
         _itemContainer = ComponentFactory.Instance.creatComponentByStylename("ddtshop.newBugleViewItemContainer");
         var _loc1_:AlertInfo = new AlertInfo("",LanguageMgr.GetTranslation("tank.dialog.showbugleframe.ok"));
         _frame.info = _loc1_;
         _frame.moveEnable = false;
         _frame.addToContent(_itemContainer);
         _frame.addEventListener("response",__frameEventHandler);
         addChild(_frame);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("com.quickBuyFrame.selectBtn");
         _selectedBtn.x = 158;
         _selectedBtn.y = 152;
         _selectedBtn.enable = false;
         _selectedBtn.selected = true;
         _frame.addToContent(_selectedBtn);
         _isBand = false;
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
         _moneyTxt.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple");
         _moneyTxt.x = 165;
         _moneyTxt.y = 160;
         _frame.addToContent(_moneyTxt);
         if(_type != 11100)
         {
            _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("com.quickBuyFrame.selectbandBtn");
            _selectedBandBtn.x = 236;
            _selectedBandBtn.y = 152;
            _frame.addToContent(_selectedBandBtn);
            _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
            _bandMoneyTxt.x = 258;
            _bandMoneyTxt.y = 160;
            _bandMoneyTxt.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.bandStipple");
            _frame.addToContent(_bandMoneyTxt);
            _selectedBtn.x = 85;
            _selectedBandBtn.addEventListener("click",selectedBandHander);
            _selectedBtn.addEventListener("click",seletedHander);
            _moneyTxt.x = 89;
         }
         updateView();
         _itemGroup.selectIndex = 0;
         StageReferance.stage.addEventListener("keyDown",__onKeyDownd);
      }
      
      protected function selectedBandHander(param1:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _isBand = true;
            _selectedBandBtn.enable = false;
            _selectedBandBtn.selected = true;
            _selectedBtn.selected = false;
            _selectedBtn.enable = true;
         }
         else
         {
            _isBand = false;
         }
         if(_isBand)
         {
            _text2.text = (_itemContainer.getChildAt(_itemGroup.selectIndex) as NewShopBugViewItem).money + LanguageMgr.GetTranslation("ddtMoney");
         }
         else
         {
            _text2.text = (_itemContainer.getChildAt(_itemGroup.selectIndex) as NewShopBugViewItem).money + LanguageMgr.GetTranslation("money");
         }
      }
      
      protected function seletedHander(param1:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _isBand = false;
            _selectedBandBtn.selected = false;
            _selectedBandBtn.enable = true;
            _selectedBtn.enable = false;
            _selectedBtn.selected = true;
         }
         else
         {
            _isBand = true;
         }
         if(_isBand)
         {
            _text2.text = (_itemContainer.getChildAt(_itemGroup.selectIndex) as NewShopBugViewItem).money + LanguageMgr.GetTranslation("ddtMoney");
         }
         else
         {
            _text2.text = (_itemContainer.getChildAt(_itemGroup.selectIndex) as NewShopBugViewItem).money + LanguageMgr.GetTranslation("money");
         }
      }
      
      private function updateView() : void
      {
         clearAllItem();
         addItems();
      }
   }
}
