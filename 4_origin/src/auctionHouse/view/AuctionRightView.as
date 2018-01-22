package auctionHouse.view
{
   import auctionHouse.event.AuctionHouseEvent;
   import auctionHouse.model.AuctionHouseModel;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AuctionRightView extends Sprite implements Disposeable
   {
       
      
      private var _prePage_btn:BaseButton;
      
      private var _nextPage_btn:BaseButton;
      
      private var _first_btn:BaseButton;
      
      private var _end_btn:BaseButton;
      
      public var page_txt:FilterFrameText;
      
      private var _sorttxtItems:Vector.<FilterFrameText>;
      
      private var _sortBtItems:Vector.<Sprite>;
      
      private var _sortArrowItems:Vector.<ScaleFrameImage>;
      
      private var _stripList:ListPanel;
      
      private var _state:String;
      
      private var _currentButtonIndex:uint = 0;
      
      private var _currentIsdown:Boolean = true;
      
      private var _selectStrip:StripView;
      
      private var _selectInfo:AuctionGoodsInfo;
      
      private var help_mc:Bitmap;
      
      private var help_BG:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _bidNumberTxt:FilterFrameText;
      
      private var _RemainingTimeTxt:FilterFrameText;
      
      private var _SellPersonTxt:FilterFrameText;
      
      private var _bidpriceTxt:FilterFrameText;
      
      private var _BidPersonTxt:FilterFrameText;
      
      private var _tableline:Bitmap;
      
      private var _tableline1:Bitmap;
      
      private var _tableline2:Bitmap;
      
      private var _tableline3:Bitmap;
      
      private var _tableline4:Bitmap;
      
      private var GoodsName_btn:Sprite;
      
      private var RemainingTime_btn:Sprite;
      
      private var SellPerson_btn:Sprite;
      
      private var BidPrice_btn:Sprite;
      
      private var BidPerson_btn:Sprite;
      
      private var _startNum:int = 0;
      
      private var _endNum:int = 0;
      
      private var _totalCount:int = 0;
      
      public function AuctionRightView()
      {
         super();
      }
      
      public function setup(param1:String = "") : void
      {
         _state = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _sortBtItems = new Vector.<Sprite>(6);
         _sorttxtItems = new Vector.<FilterFrameText>(6);
         _sortArrowItems = new Vector.<ScaleFrameImage>(4);
         var _loc3_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.RightBG1");
         addChild(_loc3_);
         var _loc1_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("asset.auctionHouse.Browse.PageCountBg");
         addChild(_loc1_);
         help_BG = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.HelpBG");
         addChild(help_BG);
         help_mc = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.Help");
         addChild(help_mc);
         _prePage_btn = ComponentFactory.Instance.creat("auctionHouse.Prev_btn");
         addChild(_prePage_btn);
         _nextPage_btn = ComponentFactory.Instance.creat("auctionHouse.Next_btn");
         addChild(_nextPage_btn);
         _first_btn = ComponentFactory.Instance.creat("auctionHouse.first_btn");
         _end_btn = ComponentFactory.Instance.creat("auctionHouse.end_btn");
         page_txt = ComponentFactory.Instance.creat("auctionHouse.RightPageText");
         addChild(page_txt);
         var _loc6_:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG");
         addChild(_loc6_);
         _nameTxt = ComponentFactory.Instance.creat("ddtauction.nameTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.name");
         _bidNumberTxt = ComponentFactory.Instance.creat("ddtauction.bidNumerTxt");
         _bidNumberTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.number");
         addChild(_bidNumberTxt);
         _RemainingTimeTxt = ComponentFactory.Instance.creat("ddtauction.remainingTimeTxt");
         _RemainingTimeTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.timer");
         _SellPersonTxt = ComponentFactory.Instance.creat("ddtauction.SellPersonTxt");
         _SellPersonTxt.text = LanguageMgr.GetTranslation("singlePrice");
         _BidPersonTxt = ComponentFactory.Instance.creat("ddtauction.BidPersonTxt");
         _BidPersonTxt.text = LanguageMgr.GetTranslation("singlePrice");
         _bidpriceTxt = ComponentFactory.Instance.creat("ddtauction.BidPriceTxt");
         _bidpriceTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.price");
         _tableline = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline);
         _tableline.x = 264;
         _tableline1 = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline1);
         _tableline1.x = 314;
         _tableline2 = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline2);
         _tableline2.x = 426;
         _tableline3 = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline3);
         _tableline3.x = 517;
         _tableline4 = ComponentFactory.Instance.creatBitmap("asset.ddtcore.TwotableLine");
         addChild(_tableline4);
         GoodsName_btn = new Sprite();
         GoodsName_btn.graphics.beginFill(16777215,1);
         GoodsName_btn.graphics.drawRect(0,6,190,30);
         GoodsName_btn.graphics.endFill();
         GoodsName_btn.alpha = 0;
         GoodsName_btn.buttonMode = true;
         addChild(GoodsName_btn);
         GoodsName_btn.x = 74;
         RemainingTime_btn = new Sprite();
         RemainingTime_btn.graphics.beginFill(16777215,1);
         RemainingTime_btn.graphics.drawRect(0,6,109,30);
         RemainingTime_btn.graphics.endFill();
         RemainingTime_btn.alpha = 0;
         RemainingTime_btn.buttonMode = true;
         addChild(RemainingTime_btn);
         RemainingTime_btn.x = 317;
         SellPerson_btn = new Sprite();
         SellPerson_btn.graphics.beginFill(16777215,1);
         SellPerson_btn.graphics.drawRect(0,6,88,30);
         SellPerson_btn.graphics.endFill();
         SellPerson_btn.alpha = 0;
         SellPerson_btn.buttonMode = true;
         addChild(SellPerson_btn);
         SellPerson_btn.x = 429;
         BidPrice_btn = new Sprite();
         BidPrice_btn.graphics.beginFill(16777215,1);
         BidPrice_btn.graphics.drawRect(0,6,173,30);
         BidPrice_btn.graphics.endFill();
         BidPrice_btn.alpha = 0;
         BidPrice_btn.buttonMode = true;
         addChild(BidPrice_btn);
         BidPrice_btn.x = 520;
         BidPerson_btn = new Sprite();
         BidPerson_btn.graphics.beginFill(16777215,1);
         BidPerson_btn.graphics.drawRect(0,6,88,30);
         BidPerson_btn.graphics.endFill();
         BidPerson_btn.alpha = 0;
         BidPerson_btn.buttonMode = true;
         BidPerson_btn.x = 429;
         addChild(BidPerson_btn);
         _sorttxtItems[0] = _nameTxt;
         _sorttxtItems[2] = _RemainingTimeTxt;
         _sorttxtItems[3] = _SellPersonTxt;
         _sorttxtItems[4] = _bidpriceTxt;
         _sorttxtItems[5] = _BidPersonTxt;
         _loc5_ = 0;
         while(_loc5_ < _sorttxtItems.length)
         {
            if(_loc5_ != 1)
            {
               if(_loc5_ == 3)
               {
                  if(_state == "browse")
                  {
                     addChild(_sorttxtItems[_loc5_]);
                  }
               }
               else if(_loc5_ == 5)
               {
                  if(_state == "sell")
                  {
                     addChild(_sorttxtItems[_loc5_]);
                  }
               }
               else
               {
                  addChild(_sorttxtItems[_loc5_]);
               }
            }
            _loc5_++;
         }
         _sortBtItems[0] = GoodsName_btn;
         _sortBtItems[2] = RemainingTime_btn;
         _sortBtItems[3] = SellPerson_btn;
         _sortBtItems[4] = BidPrice_btn;
         _sortBtItems[5] = BidPerson_btn;
         _loc4_ = 0;
         while(_loc4_ < _sortBtItems.length)
         {
            if(_loc4_ != 1)
            {
               if(_loc4_ == 3)
               {
                  if(_state == "browse")
                  {
                     addChild(_sortBtItems[_loc4_]);
                  }
               }
               else if(_loc4_ == 5)
               {
                  if(_state == "sell")
                  {
                     addChild(_sortBtItems[_loc4_]);
                  }
               }
               else
               {
                  addChild(_sortBtItems[_loc4_]);
               }
            }
            _loc4_++;
         }
         _sortArrowItems[0] = ComponentFactory.Instance.creat("auctionHouse.ArrowI");
         _sortArrowItems[1] = ComponentFactory.Instance.creat("auctionHouse.ArrowII");
         _sortArrowItems[2] = ComponentFactory.Instance.creat("auctionHouse.ArrowIII");
         _sortArrowItems[3] = ComponentFactory.Instance.creat("auctionHouse.ArrowV");
         var _loc8_:int = 0;
         var _loc7_:* = _sortArrowItems;
         for each(var _loc2_ in _sortArrowItems)
         {
            addChild(_loc2_);
            _loc2_.visible = false;
         }
         _stripList = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.rightListII");
         addChild(_stripList);
         _stripList.list.updateListView();
         _stripList.list.addEventListener("listItemClick",__itemClick);
         if(_state == "sell")
         {
            help_mc.visible = false;
            help_BG.visible = false;
         }
         addStageInit();
         _nextPage_btn.enable = false;
         _prePage_btn.enable = false;
         _first_btn.enable = false;
         _end_btn.enable = false;
      }
      
      private function addEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _sortBtItems.length)
         {
            if(_loc1_ != 1)
            {
               _sortBtItems[_loc1_].addEventListener("click",sortHandler);
            }
            _loc1_++;
         }
      }
      
      public function addStageInit() : void
      {
      }
      
      public function hideReady() : void
      {
         _hideArrow();
      }
      
      public function addAuction(param1:AuctionGoodsInfo) : void
      {
         _stripList.vectorListModel.append(param1);
         _stripList.list.updateListView();
         help_mc.visible = false;
         help_BG.visible = false;
      }
      
      public function updateAuction(param1:AuctionGoodsInfo) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _stripList.vectorListModel.elements;
         for each(var _loc3_ in _stripList.vectorListModel.elements)
         {
            if(_loc3_.AuctionID == param1.AuctionID)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         if(_loc2_ != null)
         {
            param1.BagItemInfo = _loc2_.BagItemInfo;
         }
         if(_stripList.vectorListModel.indexOf(_loc2_) != -1)
         {
            _stripList.vectorListModel.replaceAt(_stripList.vectorListModel.indexOf(_loc2_),param1);
         }
         else
         {
            _stripList.vectorListModel.append(param1);
         }
         _stripList.list.updateListView();
      }
      
      function getStripCount() : int
      {
         return _stripList.vectorListModel.size();
      }
      
      function setPage(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         param1 = 1 + AuctionHouseModel.SINGLE_PAGE_NUM * (param1 - 1);
         if(param1 + AuctionHouseModel.SINGLE_PAGE_NUM - 1 < param2)
         {
            _loc3_ = int(param1 + AuctionHouseModel.SINGLE_PAGE_NUM - 1);
         }
         else
         {
            _loc3_ = param2;
         }
         _startNum = param1;
         _endNum = _loc3_;
         _totalCount = param2;
         if(param2 == 0)
         {
            if(_stripList.vectorListModel.elements.length == 0)
            {
               page_txt.text = "";
            }
         }
         else
         {
            page_txt.text = (int(_startNum / AuctionHouseModel.SINGLE_PAGE_NUM) + 1).toString() + "/" + (int((_totalCount - 1) / AuctionHouseModel.SINGLE_PAGE_NUM) + 1).toString();
         }
         buttonStatus(param1,_loc3_,param2);
      }
      
      private function upPageTxt() : void
      {
         if(_endNum < _startNum)
         {
            page_txt.text = "";
         }
         else
         {
            page_txt.text = (int(_startNum / AuctionHouseModel.SINGLE_PAGE_NUM) + 1).toString() + "/" + (int((_totalCount - 1) / AuctionHouseModel.SINGLE_PAGE_NUM) + 1).toString();
         }
         if(_stripList.vectorListModel.elements.length == 0)
         {
            page_txt.text = "";
         }
         if(_endNum < _totalCount)
         {
            _nextPage_btn.enable = true;
            _end_btn.enable = true;
         }
         else
         {
            _nextPage_btn.enable = false;
            _end_btn.enable = false;
         }
      }
      
      private function buttonStatus(param1:int, param2:int, param3:int) : void
      {
         if(param1 <= 1)
         {
            _prePage_btn.enable = false;
            _first_btn.enable = false;
         }
         else
         {
            _prePage_btn.enable = true;
            _first_btn.enable = true;
         }
         if(param2 < param3)
         {
            _nextPage_btn.enable = true;
            _end_btn.enable = true;
         }
         else
         {
            _nextPage_btn.enable = false;
            _end_btn.enable = false;
         }
         _nextPage_btn.alpha = 1;
         _prePage_btn.alpha = 1;
      }
      
      function clearList() : void
      {
         _clearItems();
         _selectInfo = null;
         page_txt.text = "";
         if(_state == "browse")
         {
            help_mc.visible = true;
            help_BG.visible = true;
         }
         if(_stripList.vectorListModel.elements.length == 0)
         {
            help_mc.visible = true;
            help_BG.visible = true;
         }
         else
         {
            help_mc.visible = false;
            help_BG.visible = false;
         }
         if(_state == "sell")
         {
            help_mc.visible = false;
            help_BG.visible = false;
         }
      }
      
      private function _clearItems() : void
      {
         _stripList.vectorListModel.clear();
         _stripList.list.updateListView();
      }
      
      private function invalidatePanel() : void
      {
      }
      
      function getSelectInfo() : AuctionGoodsInfo
      {
         if(_selectInfo)
         {
            return _selectInfo;
         }
         return null;
      }
      
      function deleteItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _stripList.vectorListModel.elements;
         for each(var _loc1_ in _stripList.vectorListModel.elements)
         {
            if(_loc1_.AuctioneerID == _selectInfo.AuctioneerID)
            {
               _stripList.vectorListModel.remove(_loc1_);
               _selectInfo = null;
               upPageTxt();
               break;
            }
         }
         _stripList.list.updateListView();
      }
      
      function clearSelectStrip() : void
      {
         _stripList.vectorListModel.remove(_selectInfo);
         _selectInfo = null;
         upPageTxt();
         _stripList.list.unSelectedAll();
         _stripList.list.updateListView();
      }
      
      function setSelectEmpty() : void
      {
         _selectStrip.isSelect = false;
         _selectStrip = null;
         _selectInfo = null;
      }
      
      function get sortCondition() : int
      {
         return _currentButtonIndex;
      }
      
      function get sortBy() : Boolean
      {
         return _currentIsdown;
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         var _loc2_:StripView = param1.cell as StripView;
         _selectStrip = _loc2_;
         _selectInfo = _loc2_.info;
         dispatchEvent(new AuctionHouseEvent("selectStrip"));
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _sortBtItems.length)
         {
            if(_loc1_ != 1)
            {
               _sortBtItems[_loc1_].removeEventListener("click",sortHandler);
               ObjectUtils.disposeObject(_sortBtItems[_loc1_]);
            }
            _loc1_++;
         }
         _sortBtItems = null;
      }
      
      private function sortHandler(param1:MouseEvent) : void
      {
         AuctionHouseModel._dimBooble = false;
         SoundManager.instance.play("047");
         var _loc2_:uint = _sortBtItems.indexOf(param1.target as Sprite);
         if(_currentButtonIndex == _loc2_)
         {
            changeArrow(_loc2_,!_currentIsdown);
         }
         else
         {
            changeArrow(_loc2_,true);
         }
      }
      
      private function _showOneArrow(param1:uint) : void
      {
         _hideArrow();
         _sortArrowItems[param1].visible = true;
      }
      
      private function _hideArrow() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _sortArrowItems;
         for each(var _loc1_ in _sortArrowItems)
         {
            _loc1_.visible = false;
         }
      }
      
      private function changeArrow(param1:uint, param2:Boolean) : void
      {
         var _loc3_:* = param1;
         if(param1 == 5)
         {
            param1 = 3;
         }
         param1 = param1 == 0?0:Number(param1 - 1);
         _showOneArrow(param1);
         _currentIsdown = param2;
         _currentButtonIndex = _loc3_;
         AuctionHouseModel.searchType = 3;
         if(param2)
         {
            _sortArrowItems[param1].setFrame(2);
         }
         else
         {
            _sortArrowItems[param1].setFrame(1);
         }
         if(_stripList.vectorListModel.elements.length < 1)
         {
            return;
         }
         if(param2)
         {
            _stripList.vectorListModel.elements.sortOn("Price",16);
         }
         else
         {
            _stripList.vectorListModel.elements.sortOn("Price",2 | 16);
         }
         dispatchEvent(new AuctionHouseEvent("sortChange"));
      }
      
      public function get prePage_btn() : BaseButton
      {
         return _prePage_btn;
      }
      
      public function get nextPage_btn() : BaseButton
      {
         return _nextPage_btn;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _selectInfo = null;
         if(_first_btn)
         {
            ObjectUtils.disposeObject(_first_btn);
         }
         _first_btn = null;
         if(_end_btn)
         {
            ObjectUtils.disposeObject(_end_btn);
         }
         _end_btn = null;
         if(_prePage_btn)
         {
            ObjectUtils.disposeObject(_prePage_btn);
         }
         _prePage_btn = null;
         if(_nextPage_btn)
         {
            ObjectUtils.disposeObject(_nextPage_btn);
         }
         _nextPage_btn = null;
         if(page_txt)
         {
            ObjectUtils.disposeObject(page_txt);
         }
         page_txt = null;
         var _loc3_:int = 0;
         var _loc2_:* = _sortArrowItems;
         for each(var _loc1_ in _sortArrowItems)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _sortArrowItems = null;
         if(_selectStrip)
         {
            ObjectUtils.disposeObject(_selectStrip);
         }
         _selectStrip = null;
         _stripList.vectorListModel.clear();
         if(_stripList)
         {
            _stripList.list.removeEventListener("listItemClick",__itemClick);
            ObjectUtils.disposeObject(_stripList);
         }
         _stripList = null;
         if(help_mc)
         {
            ObjectUtils.disposeObject(help_mc);
         }
         help_mc = null;
         if(help_BG)
         {
            ObjectUtils.disposeObject(help_BG);
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
