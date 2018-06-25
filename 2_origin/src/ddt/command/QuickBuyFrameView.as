package ddt.command
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.Price;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuickBuyFrameView extends Sprite implements Disposeable
   {
       
      
      private var _number:NumberSelecter;
      
      private var _itemTemplateInfo:ItemTemplateInfo;
      
      private var _shopItem:ShopItemInfo;
      
      private var _cell:BaseCell;
      
      private var _totalTipText:FilterFrameText;
      
      protected var _totalText:FilterFrameText;
      
      public var _itemID:int;
      
      protected var _stoneNumber:int = 1;
      
      private var _price:int;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoney:FilterFrameText;
      
      protected var _isBand:Boolean;
      
      private var _movieBack:MovieClip;
      
      private var _type:int = 0;
      
      private var _time:int = 1;
      
      public function QuickBuyFrameView()
      {
         super();
         initView();
         initEvents();
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function set time(value:int) : void
      {
         _time = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get isBand() : Boolean
      {
         return _isBand;
      }
      
      public function set isBand(b:Boolean) : void
      {
         _isBand = b;
      }
      
      private function initView() : void
      {
         var bg:Image = ComponentFactory.Instance.creatComponentByStylename("ddtcore.CellBg");
         addChild(bg);
         _number = ComponentFactory.Instance.creatCustomObject("ddtcore.numberSelecter");
         addChild(_number);
         var cellBG:Sprite = new Sprite();
         cellBG.addChild(ComponentFactory.Instance.creatBitmap("asset.ddtcore.EquipCellBG"));
         _movieBack = ComponentFactory.Instance.creat("asset.core.stranDown");
         _movieBack.x = 176;
         _movieBack.y = 116;
         addChild(_movieBack);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBtn.selected = true;
         _selectedBtn.x = 83;
         _selectedBtn.y = 101;
         _selectedBtn.enable = false;
         addChild(_selectedBtn);
         _selectedBtn.addEventListener("click",seletedHander);
         _isBand = false;
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBandBtn.enable = true;
         _selectedBandBtn.selected = false;
         _selectedBandBtn.x = 183;
         _selectedBandBtn.y = 101;
         addChild(_selectedBandBtn);
         _selectedBandBtn.addEventListener("click",selectedBandHander);
         _totalTipText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalTipsText");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         addChild(_totalTipText);
         _totalText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalText");
         addChild(_totalText);
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _moneyTxt.x = 55;
         _moneyTxt.y = 107;
         _moneyTxt.text = LanguageMgr.GetTranslation("ddt.money");
         addChild(_moneyTxt);
         _bandMoney = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _bandMoney.x = 173;
         _bandMoney.y = 107;
         _bandMoney.text = LanguageMgr.GetTranslation("ddt.bandMoney");
         addChild(_bandMoney);
         _cell = new BaseCell(cellBG);
         _cell.x = bg.x + 4;
         _cell.y = bg.y + 4;
         addChild(_cell);
         _cell.tipDirctions = "7,0";
         refreshNumText();
      }
      
      protected function selectedBandHander(event:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _isBand = true;
            _selectedBandBtn.enable = false;
            _selectedBtn.selected = false;
            _selectedBtn.enable = true;
         }
         else
         {
            _isBand = false;
         }
         refreshNumText();
      }
      
      protected function seletedHander(event:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _isBand = false;
            _selectedBandBtn.selected = false;
            _selectedBandBtn.enable = true;
            _selectedBtn.enable = false;
         }
         else
         {
            _isBand = true;
         }
         refreshNumText();
      }
      
      private function initEvents() : void
      {
         _number.addEventListener("change",selectHandler);
         _number.addEventListener("number_close",_numberClose);
      }
      
      private function selectHandler(e:Event) : void
      {
         _stoneNumber = _number.number;
         refreshNumText();
      }
      
      private function _numberClose(e:Event) : void
      {
         dispatchEvent(e);
      }
      
      public function hideSelectedBand() : void
      {
         var _loc1_:Boolean = false;
         _selectedBandBtn.visible = _loc1_;
         _bandMoney.visible = _loc1_;
         _moneyTxt.x = _moneyTxt.x + 50;
         _selectedBtn.x = _selectedBtn.x + 50;
         _selectedBtn.selected = true;
         _selectedBandBtn.selected = false;
         _selectedBandBtn.enable = false;
         _selectedBtn.enable = false;
         _isBand = false;
         refreshNumText();
      }
      
      public function hideSelected() : void
      {
         var _loc1_:Boolean = false;
         _selectedBtn.visible = _loc1_;
         _moneyTxt.visible = _loc1_;
         _bandMoney.x = _bandMoney.x - 50;
         _selectedBandBtn.x = _selectedBandBtn.x - 50;
         _selectedBandBtn.selected = true;
         _selectedBtn.selected = false;
         _selectedBandBtn.enable = false;
         _selectedBtn.enable = false;
         _isBand = true;
         refreshNumText();
      }
      
      public function set ItemID(ID:int) : void
      {
         var _loc2_:* = true;
         _selectedBandBtn.visible = _loc2_;
         _loc2_ = _loc2_;
         _selectedBtn.visible = _loc2_;
         _loc2_ = _loc2_;
         _bandMoney.visible = _loc2_;
         _moneyTxt.visible = _loc2_;
         _itemID = ID;
         if(_itemID == 11023)
         {
            _stoneNumber = 3;
         }
         else
         {
            _stoneNumber = 1;
         }
         _number.number = _stoneNumber;
         _shopItem = ShopManager.Instance.getMoneyShopItemByTemplateID(_itemID);
         initInfo();
         refreshNumText();
      }
      
      public function setItemID(ID:int, type:int, time:int) : void
      {
         _itemID = ID;
         _type = type;
         _time = time;
         if(_itemID == 11023)
         {
            _stoneNumber = 3;
         }
         else
         {
            _stoneNumber = 1;
         }
         _number.number = _stoneNumber;
         if(type == 1 || type == 2 || type == 4 || type == 5 || type == 6)
         {
            var _loc4_:* = false;
            _selectedBandBtn.visible = _loc4_;
            _loc4_ = _loc4_;
            _selectedBtn.visible = _loc4_;
            _loc4_ = _loc4_;
            _bandMoney.visible = _loc4_;
            _moneyTxt.visible = _loc4_;
            totalText.y = 108;
            totalTipText.y = 108;
         }
         else if(type == 3)
         {
            _selectedBandBtn.selected = true;
            _isBand = true;
            _selectedBandBtn.enable = false;
            _selectedBtn.selected = false;
            _selectedBtn.enable = true;
            _number.ennable = false;
            _loc4_ = true;
            _selectedBandBtn.visible = _loc4_;
            _loc4_ = _loc4_;
            _selectedBtn.visible = _loc4_;
            _loc4_ = _loc4_;
            _bandMoney.visible = _loc4_;
            _moneyTxt.visible = _loc4_;
         }
         _shopItem = ShopManager.Instance.getShopItemByTemplateID(_itemID,_type);
         initInfo();
         refreshNumText();
      }
      
      public function set stoneNumber(value:int) : void
      {
         _stoneNumber = value;
         _number.number = _stoneNumber;
         refreshNumText();
      }
      
      public function get stoneNumber() : int
      {
         return _stoneNumber;
      }
      
      public function get ItemID() : int
      {
         return _itemID;
      }
      
      public function set maxLimit(value:int) : void
      {
         _number.maximum = value;
      }
      
      private function initInfo() : void
      {
         _itemTemplateInfo = ItemManager.Instance.getTemplateById(_itemID);
         _cell.info = _itemTemplateInfo;
      }
      
      protected function refreshNumText() : void
      {
         switch(int(_type))
         {
            case 0:
               _price = _shopItem == null?0:_shopItem.getItemPrice(1).bothMoneyValue;
               if(_isBand)
               {
                  totalText.text = String(_stoneNumber * _price) + " " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.bandStipple");
               }
               else
               {
                  totalText.text = String(_stoneNumber * _price) + " " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple");
               }
               break;
            case 1:
               _price = _shopItem == null?0:_shopItem.getItemPrice(1).hardCurrencyValue;
               totalText.text = String(_stoneNumber * _price) + " " + LanguageMgr.GetTranslation("dt.labyrinth.LabyrinthShopFrame.text1");
               break;
            case 2:
               _price = _shopItem == null?0:_shopItem.getItemPrice(1).gesteValue;
               totalText.text = String(_stoneNumber * _price) + " " + LanguageMgr.GetTranslation("gongxun");
               break;
            case 3:
               _price = _shopItem == null?0:_shopItem.getItemPrice(_time).bothMoneyValue;
               if(_isBand)
               {
                  totalText.text = String(_stoneNumber * _price) + " " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.bandStipple");
               }
               else
               {
                  totalText.text = String(_stoneNumber * _price) + " " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple");
               }
               break;
            case 4:
               _price = _shopItem == null?0:_shopItem.getItemPrice(1).leagueValue;
               totalText.text = String(_stoneNumber * _price) + " " + Price.LEAGUESTRING;
               break;
            case 5:
               _price = _shopItem == null?0:_shopItem.getItemPrice(1).scoreValue;
               totalText.text = String(_stoneNumber * _price) + " " + Price.SCORETOSTRING;
               break;
            case 6:
               _price = _shopItem == null?0:_shopItem.getItemPrice(1).badgeValue;
               totalText.text = String(_stoneNumber * _price) + " " + Price.BADGE_STRING;
         }
      }
      
      public function get numberSelecter() : NumberSelecter
      {
         return _number;
      }
      
      public function get totalTipText() : FilterFrameText
      {
         return _totalTipText;
      }
      
      public function get totalText() : FilterFrameText
      {
         return _totalText;
      }
      
      public function dispose() : void
      {
         if(_number)
         {
            _number.removeEventListener("cancel",selectHandler);
            _number.removeEventListener("number_close",_numberClose);
            ObjectUtils.disposeObject(_number);
         }
         if(_selectedBtn)
         {
            _selectedBtn.removeEventListener("click",seletedHander);
         }
         if(_selectedBandBtn)
         {
            _selectedBandBtn.removeEventListener("click",selectedBandHander);
         }
         ObjectUtils.disposeObject(_selectedBandBtn);
         ObjectUtils.disposeObject(_selectedBtn);
         ObjectUtils.disposeObject(_moneyTxt);
         ObjectUtils.disposeObject(_bandMoney);
         if(_totalTipText)
         {
            ObjectUtils.disposeObject(_totalTipText);
         }
         _totalTipText = null;
         if(_totalText)
         {
            ObjectUtils.disposeObject(_totalText);
         }
         _totalText = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         _number = null;
         _itemTemplateInfo = null;
         _shopItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
