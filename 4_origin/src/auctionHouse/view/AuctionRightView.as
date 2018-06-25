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
      
      public function setup($state:String = "") : void
      {
         _state = $state;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var j:int = 0;
         _sortBtItems = new Vector.<Sprite>(6);
         _sorttxtItems = new Vector.<FilterFrameText>(6);
         _sortArrowItems = new Vector.<ScaleFrameImage>(4);
         var bg1:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.RightBG1");
         addChild(bg1);
         var PageBg:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("asset.auctionHouse.Browse.PageCountBg");
         addChild(PageBg);
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
         var _sellItembg:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG");
         addChild(_sellItembg);
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
         _tableline.x = 258;
         _tableline1 = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline1);
         _tableline1.x = 323;
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
         GoodsName_btn.graphics.drawRect(0,6,186,30);
         GoodsName_btn.graphics.endFill();
         GoodsName_btn.alpha = 0;
         GoodsName_btn.buttonMode = true;
         addChild(GoodsName_btn);
         GoodsName_btn.x = 74;
         RemainingTime_btn = new Sprite();
         RemainingTime_btn.graphics.beginFill(16777215,1);
         RemainingTime_btn.graphics.drawRect(0,6,103,30);
         RemainingTime_btn.graphics.endFill();
         RemainingTime_btn.alpha = 0;
         RemainingTime_btn.buttonMode = true;
         addChild(RemainingTime_btn);
         RemainingTime_btn.x = 323;
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
         for(i = 0; i < _sorttxtItems.length; )
         {
            if(i != 1)
            {
               if(i == 3)
               {
                  if(_state == "browse")
                  {
                     addChild(_sorttxtItems[i]);
                  }
               }
               else if(i == 5)
               {
                  if(_state == "sell")
                  {
                     addChild(_sorttxtItems[i]);
                  }
               }
               else
               {
                  addChild(_sorttxtItems[i]);
               }
            }
            i++;
         }
         _sortBtItems[0] = GoodsName_btn;
         _sortBtItems[2] = RemainingTime_btn;
         _sortBtItems[3] = SellPerson_btn;
         _sortBtItems[4] = BidPrice_btn;
         _sortBtItems[5] = BidPerson_btn;
         for(j = 0; j < _sortBtItems.length; )
         {
            if(j != 1)
            {
               if(j == 3)
               {
                  if(_state == "browse")
                  {
                     addChild(_sortBtItems[j]);
                  }
               }
               else if(j == 5)
               {
                  if(_state == "sell")
                  {
                     addChild(_sortBtItems[j]);
                  }
               }
               else
               {
                  addChild(_sortBtItems[j]);
               }
            }
            j++;
         }
         _sortArrowItems[0] = ComponentFactory.Instance.creat("auctionHouse.ArrowI");
         _sortArrowItems[1] = ComponentFactory.Instance.creat("auctionHouse.ArrowII");
         _sortArrowItems[2] = ComponentFactory.Instance.creat("auctionHouse.ArrowIII");
         _sortArrowItems[3] = ComponentFactory.Instance.creat("auctionHouse.ArrowV");
         var _loc8_:int = 0;
         var _loc7_:* = _sortArrowItems;
         for each(var img in _sortArrowItems)
         {
            addChild(img);
            img.visible = false;
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
         var i:int = 0;
         for(i = 0; i < _sortBtItems.length; )
         {
            if(i != 1)
            {
               _sortBtItems[i].addEventListener("click",sortHandler);
            }
            i++;
         }
      }
      
      public function addStageInit() : void
      {
      }
      
      public function hideReady() : void
      {
         _hideArrow();
      }
      
      public function addAuction(info:AuctionGoodsInfo) : void
      {
         _stripList.vectorListModel.append(info);
         _stripList.list.updateListView();
         help_mc.visible = false;
         help_BG.visible = false;
      }
      
      public function updateAuction(info:AuctionGoodsInfo) : void
      {
         var targetItem:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _stripList.vectorListModel.elements;
         for each(var item in _stripList.vectorListModel.elements)
         {
            if(item.AuctionID == info.AuctionID)
            {
               targetItem = item;
               break;
            }
         }
         if(targetItem != null)
         {
            info.BagItemInfo = targetItem.BagItemInfo;
         }
         if(_stripList.vectorListModel.indexOf(targetItem) != -1)
         {
            _stripList.vectorListModel.replaceAt(_stripList.vectorListModel.indexOf(targetItem),info);
         }
         else
         {
            _stripList.vectorListModel.append(info);
         }
         _stripList.list.updateListView();
      }
      
      function getStripCount() : int
      {
         return _stripList.vectorListModel.size();
      }
      
      function setPage(start:int, totalCount:int) : void
      {
         var end:* = 0;
         start = 1 + AuctionHouseModel.SINGLE_PAGE_NUM * (start - 1);
         if(start + AuctionHouseModel.SINGLE_PAGE_NUM - 1 < totalCount)
         {
            end = int(start + AuctionHouseModel.SINGLE_PAGE_NUM - 1);
         }
         else
         {
            end = totalCount;
         }
         _startNum = start;
         _endNum = end;
         _totalCount = totalCount;
         if(totalCount == 0)
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
         buttonStatus(start,end,totalCount);
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
      
      private function buttonStatus(start:int, end:int, totalCount:int) : void
      {
         if(start <= 1)
         {
            _prePage_btn.enable = false;
            _first_btn.enable = false;
         }
         else
         {
            _prePage_btn.enable = true;
            _first_btn.enable = true;
         }
         if(end < totalCount)
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
         for each(var info1 in _stripList.vectorListModel.elements)
         {
            if(info1.AuctioneerID == _selectInfo.AuctioneerID)
            {
               _stripList.vectorListModel.remove(info1);
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
      
      private function __itemClick(evt:ListItemEvent) : void
      {
         var currentStrip:StripView = evt.cell as StripView;
         _selectStrip = currentStrip;
         _selectInfo = currentStrip.info;
         dispatchEvent(new AuctionHouseEvent("selectStrip"));
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _sortBtItems.length; )
         {
            if(i != 1)
            {
               _sortBtItems[i].removeEventListener("click",sortHandler);
               ObjectUtils.disposeObject(_sortBtItems[i]);
            }
            i++;
         }
         _sortBtItems = null;
      }
      
      private function sortHandler(e:MouseEvent) : void
      {
         AuctionHouseModel._dimBooble = false;
         SoundManager.instance.play("047");
         var _index:uint = _sortBtItems.indexOf(e.target as Sprite);
         if(_currentButtonIndex == _index)
         {
            changeArrow(_index,!_currentIsdown);
         }
         else
         {
            changeArrow(_index,true);
         }
      }
      
      private function _showOneArrow(index:uint) : void
      {
         _hideArrow();
         _sortArrowItems[index].visible = true;
      }
      
      private function _hideArrow() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _sortArrowItems;
         for each(var img in _sortArrowItems)
         {
            img.visible = false;
         }
      }
      
      private function changeArrow(index:uint, isdown:Boolean) : void
      {
         var _index:* = index;
         if(index == 5)
         {
            index = 3;
         }
         index = index == 0?0:Number(index - 1);
         _showOneArrow(index);
         _currentIsdown = isdown;
         _currentButtonIndex = _index;
         AuctionHouseModel.searchType = 3;
         if(isdown)
         {
            _sortArrowItems[index].setFrame(2);
         }
         else
         {
            _sortArrowItems[index].setFrame(1);
         }
         if(_stripList.vectorListModel.elements.length < 1)
         {
            return;
         }
         if(isdown)
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
         for each(var img in _sortArrowItems)
         {
            ObjectUtils.disposeObject(img);
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
