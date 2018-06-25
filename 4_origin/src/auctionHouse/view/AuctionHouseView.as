package auctionHouse.view
{
   import auctionHouse.IAuctionHouse;
   import auctionHouse.controller.AuctionHouseController;
   import auctionHouse.event.AuctionHouseEvent;
   import auctionHouse.model.AuctionHouseModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryEvent;
   
   public class AuctionHouseView extends Sprite implements IAuctionHouse, Disposeable
   {
       
      
      private var _model:AuctionHouseModel;
      
      private var _controller:AuctionHouseController;
      
      private var _isInit:Boolean;
      
      private var _browse:AuctionBrowseView;
      
      private var _buy:AuctionBuyView;
      
      private var _sell:AuctionSellView;
      
      private var _notesButton:BaseButton;
      
      private var _titleMc:ScaleFrameImage;
      
      private var _browse_btn:BaseButton;
      
      private var _buy_btn:BaseButton;
      
      private var _sell_btn:BaseButton;
      
      private var _money:FilterFrameText;
      
      private var _ddtauction:MovieImage;
      
      private var _ddtauctionView:MovieImage;
      
      private var moneyBG:Bitmap;
      
      private var moneyInfoBG:ScaleBitmapImage;
      
      private var _titleBroweBtn:SelectedButton;
      
      private var _titleSellBtn:SelectedButton;
      
      private var _titleBuyBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _moneyBitmap:Bitmap;
      
      private var _titleBG:Bitmap;
      
      private var _titleName:Bitmap;
      
      private var _explainTxt:FilterFrameText;
      
      public function AuctionHouseView(controller:AuctionHouseController, model:AuctionHouseModel)
      {
         super();
         _isInit = true;
         _model = model;
         _controller = controller;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         this.y = 5;
         _ddtauction = ComponentFactory.Instance.creatComponentByStylename("ddtauctionView.BG1");
         addChild(_ddtauction);
         _titleBG = ComponentFactory.Instance.creatBitmap("asset.ddtcivil.titleBg");
         addChild(_titleBG);
         _titleBG.x = 206;
         _titleBG.y = -3;
         _titleBG.height = 45;
         _titleName = ComponentFactory.Instance.creatBitmap("asset.ddtauction.titlename");
         addChild(_titleName);
         _ddtauctionView = ComponentFactory.Instance.creatComponentByStylename("ddtauctionView.BG2");
         addChild(_ddtauctionView);
         _titleBroweBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtauctionHouse.TitleAsset");
         addChild(_titleBroweBtn);
         _titleSellBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtauctionHouse.TitleSellAsset");
         addChild(_titleSellBtn);
         _titleBuyBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtauctionHouse.TitleBuyAsset");
         addChild(_titleBuyBtn);
         _explainTxt = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.explainTxt.text");
         _explainTxt.text = LanguageMgr.GetTranslation("auctionHouse.explainTxt.text",ServerConfigManager.instance.AuctionRate);
         addChild(_explainTxt);
         _browse_btn = ComponentFactory.Instance.creat("auctionHouse.Browse_btn");
         addChild(_browse_btn);
         _notesButton = HelpFrameUtils.Instance.simpleHelpButton(this,"auctionHouse.NotesButton",null,LanguageMgr.GetTranslation("ddt.auctionHouse.notesTitle"),"asset.ddtauctionHouse.NotesContent",404,484);
         _buy_btn = ComponentFactory.Instance.creat("auctionHouse.Buy_btn");
         addChild(_buy_btn);
         _sell_btn = ComponentFactory.Instance.creat("auctionHouse.Sell_btn");
         addChild(_sell_btn);
         moneyBG = ComponentFactory.Instance.creatBitmap("asset.ddtauction.moneyBG");
         addChild(moneyBG);
         moneyInfoBG = ComponentFactory.Instance.creatComponentByStylename("ddtauction.moneyInfoBG");
         addChild(moneyInfoBG);
         _money = ComponentFactory.Instance.creat("auctionHouse.money");
         addChild(_money);
         _moneyBitmap = ComponentFactory.Instance.creatBitmap("asset.core.ticketIcon");
         PositionUtils.setPos(_moneyBitmap,"asset.core.ticketIcon.pos");
         addChild(_moneyBitmap);
         _browse = new AuctionBrowseView(_controller,_model);
         _buy = new AuctionBuyView();
         _sell = new AuctionSellView(_controller,_model);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_titleBroweBtn);
         _btnGroup.addSelectItem(_titleSellBtn);
         _btnGroup.addSelectItem(_titleBuyBtn);
         _btnGroup.selectIndex = 0;
         update();
         updateAccount();
      }
      
      private function addEvent() : void
      {
         _browse_btn.addEventListener("click",__browse);
         _buy_btn.addEventListener("click",__buy);
         _sell_btn.addEventListener("click",__sell);
         _model.addEventListener("changeState",__changeState);
         _btnGroup.addEventListener("changeState",__changeState);
         _model.addEventListener("getGoodCateGory",__getCategory);
         _model.myAuctionData.addEventListener("add",__addMyAuction);
         _model.myAuctionData.addEventListener("clear",__clearMyAuction);
         _model.myAuctionData.addEventListener("update",__updateMyAuction);
         _model.browseAuctionData.addEventListener("add",__addBrowse);
         _model.browseAuctionData.addEventListener("clear",__clearBrowse);
         _model.browseAuctionData.addEventListener("remove",__removeBrowse);
         _model.browseAuctionData.addEventListener("update",__updateBrowse);
         _model.buyAuctionData.addEventListener("add",__addBuyAuction);
         _model.buyAuctionData.addEventListener("clear",__clearBuyAuction);
         _model.buyAuctionData.addEventListener("update",__updateBuyAuction);
         _model.addEventListener("updatePage",__updatePage);
         _model.addEventListener("browseTypeChange",__browserTypeChange);
         _sell.addEventListener("prePage",__prePage);
         _sell.addEventListener("nextPage",__nextPage);
         _sell.addEventListener("sortChange",__sellSortChange);
         _browse.addEventListener("prePage",__prePage);
         _browse.addEventListener("nextPage",__nextPage);
         PlayerManager.Instance.Self.addEventListener("propertychange",__changeMoney);
      }
      
      private function removeEvent() : void
      {
         _browse_btn.removeEventListener("click",__browse);
         _buy_btn.removeEventListener("click",__buy);
         _sell_btn.removeEventListener("click",__sell);
         _model.removeEventListener("changeState",__changeState);
         _model.removeEventListener("getGoodCateGory",__getCategory);
         _model.myAuctionData.removeEventListener("add",__addMyAuction);
         _model.myAuctionData.removeEventListener("clear",__clearMyAuction);
         _model.myAuctionData.removeEventListener("update",__updateMyAuction);
         _model.browseAuctionData.removeEventListener("add",__addBrowse);
         _model.browseAuctionData.removeEventListener("clear",__clearBrowse);
         _model.browseAuctionData.removeEventListener("remove",__removeBrowse);
         _model.browseAuctionData.removeEventListener("update",__updateBrowse);
         _model.buyAuctionData.removeEventListener("add",__addBuyAuction);
         _model.buyAuctionData.removeEventListener("clear",__clearBuyAuction);
         _model.buyAuctionData.removeEventListener("update",__updateBuyAuction);
         _sell.removeEventListener("prePage",__prePage);
         _sell.removeEventListener("nextPage",__nextPage);
         _sell.removeEventListener("sortChange",__sellSortChange);
         _model.removeEventListener("updatePage",__updatePage);
         _model.removeEventListener("browseTypeChange",__browserTypeChange);
         _browse.removeEventListener("prePage",__prePage);
         _browse.removeEventListener("nextPage",__nextPage);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeMoney);
      }
      
      public function forbidChangeState() : void
      {
         _browse_btn.removeEventListener("click",__browse);
         _buy_btn.removeEventListener("click",__buy);
         _sell_btn.removeEventListener("click",__sell);
      }
      
      public function allowChangeState() : void
      {
         _browse_btn.addEventListener("click",__browse);
         _buy_btn.addEventListener("click",__buy);
         _sell_btn.addEventListener("click",__sell);
      }
      
      private function __browse(event:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         _controller.setState("browse");
      }
      
      private function __buy(event:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         _controller.setState("buy");
      }
      
      private function __sell(event:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         _controller.setState("sell");
      }
      
      private function __changeState(event:AuctionHouseEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         var AuctionIDs:* = null;
         var sAuctionIDs:* = null;
         var lth:int = 0;
         var i:int = 0;
         if(_model.state == "browse")
         {
            _btnGroup.selectIndex = 0;
            _browse_btn.mouseEnabled = false;
            _buy_btn.mouseEnabled = true;
            _sell_btn.mouseEnabled = true;
            addChild(_browse);
            !!_buy.parent?removeChild(_buy):null;
            !!_sell.parent?_sell.hideReady():null;
            !!_sell.parent?removeChild(_sell):null;
            if(_isInit)
            {
               _isInit = false;
            }
         }
         else if(_model.state == "buy")
         {
            _btnGroup.selectIndex = 2;
            _browse_btn.mouseEnabled = true;
            _buy_btn.mouseEnabled = false;
            _sell_btn.mouseEnabled = true;
            addChild(_buy);
            !!_browse.parent?_browse.hideReady():null;
            !!_browse.parent?removeChild(_browse):null;
            !!_sell.parent?_sell.hideReady():null;
            !!_sell.parent?removeChild(_sell):null;
            AuctionIDs = SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID];
            sAuctionIDs = "";
            if(AuctionIDs && AuctionIDs.length > 0)
            {
               lth = AuctionIDs.length;
               sAuctionIDs = AuctionIDs[0].toString();
               if(lth > 1)
               {
                  for(i = 1; i < lth; )
                  {
                     sAuctionIDs = sAuctionIDs + ("," + AuctionIDs[i].toString());
                     i++;
                  }
               }
            }
            if(_model.buyAuctionData.length < 50)
            {
               _controller.searchAuctionList(1,"",-1,-1,-1,PlayerManager.Instance.Self.ID,0,"false",sAuctionIDs);
            }
         }
         else if(_model.state == "sell")
         {
            _btnGroup.selectIndex = 1;
            _browse_btn.mouseEnabled = true;
            _buy_btn.mouseEnabled = true;
            _sell_btn.mouseEnabled = false;
            _sell.this_left.openBagFrame();
            addChild(_sell);
            !!_browse.parent?_browse.hideReady():null;
            !!_browse.parent?removeChild(_browse):null;
            !!_buy.parent?removeChild(_buy):null;
            if(_model.myAuctionData.length < 50)
            {
               _model.sellCurrent = 1;
               _controller.searchAuctionList(1,"",-1,-1,PlayerManager.Instance.Self.ID,-1,0,"true");
            }
         }
      }
      
      public function show() : void
      {
         _controller.addChild(this);
      }
      
      public function hide() : void
      {
         dispose();
         if(parent)
         {
            _controller.removeChild(this);
         }
      }
      
      private function __updatePage(event:AuctionHouseEvent) : void
      {
         if(_model.state == "sell")
         {
            _sell.setPage(_model.sellCurrent,_model.sellTotal);
         }
         else if(_model.state == "browse")
         {
            _browse.setPage(_model.browseCurrent,_model.browseTotal);
         }
      }
      
      private function __prePage(event:AuctionHouseEvent) : void
      {
         if(_model.state == "sell")
         {
            if(_model.sellCurrent > 1)
            {
               _model.sellCurrent = _model.sellCurrent - 1;
               _sell.searchByCurCondition(_model.sellCurrent,PlayerManager.Instance.Self.ID);
            }
         }
         else if(_model.state == "browse")
         {
            if(_model.browseCurrent > 1)
            {
               _model.browseCurrent = _model.browseCurrent - 1;
               _browse.searchByCurCondition(_model.browseCurrent);
            }
         }
      }
      
      private function __nextPage(event:AuctionHouseEvent) : void
      {
         if(_model.state == "sell")
         {
            if(_model.sellCurrent < _model.sellTotalPage)
            {
               _model.sellCurrent = _model.sellCurrent + 1;
               _sell.searchByCurCondition(_model.sellCurrent,PlayerManager.Instance.Self.ID);
            }
         }
         else if(_model.state == "browse")
         {
            if(_model.browseCurrent < _model.browseTotalPage)
            {
               _model.browseCurrent = _model.browseCurrent + 1;
               _browse.searchByCurCondition(_model.browseCurrent);
            }
         }
      }
      
      private function __addMyAuction(event:DictionaryEvent) : void
      {
         _sell.addAuction(event.data as AuctionGoodsInfo);
         _sell.clearLeft();
      }
      
      private function __clearMyAuction(event:DictionaryEvent) : void
      {
         _sell.clearList();
      }
      
      private function __removeMyAuction(event:DictionaryEvent) : void
      {
         _controller.searchAuctionList(_model.sellCurrent,"",-1,-1,PlayerManager.Instance.Self.ID,-1);
      }
      
      private function __updateMyAuction(event:DictionaryEvent) : void
      {
         _sell.updateList(event.data as AuctionGoodsInfo);
      }
      
      private function __addBrowse(event:DictionaryEvent) : void
      {
         _browse.addAuction(event.data as AuctionGoodsInfo);
      }
      
      private function __removeBrowse(event:DictionaryEvent) : void
      {
         _browse.searchByCurCondition(_model.browseCurrent);
      }
      
      private function __updateBrowse(event:DictionaryEvent) : void
      {
         _browse.updateAuction(event.data as AuctionGoodsInfo);
      }
      
      private function __clearBrowse(event:DictionaryEvent) : void
      {
         _browse.clearList();
      }
      
      private function __browserTypeChange(event:AuctionHouseEvent) : void
      {
         _browse.setSelectType(_model.currentBrowseGoodInfo);
         _model.browseCurrent = 1;
         _browse.searchByCurCondition(1);
      }
      
      private function __addBuyAuction(event:DictionaryEvent) : void
      {
         _buy.addAuction(event.data as AuctionGoodsInfo);
      }
      
      private function __removeBuyAuction(event:DictionaryEvent) : void
      {
         _buy.removeAuction();
         _controller.searchAuctionList(_model.browseCurrent,"",-1,-1,-1,PlayerManager.Instance.Self.ID);
      }
      
      private function __clearBuyAuction(event:DictionaryEvent) : void
      {
         _buy.clearList();
      }
      
      private function __updateBuyAuction(event:DictionaryEvent) : void
      {
         _buy.updateAuction(event.data as AuctionGoodsInfo);
      }
      
      private function __changeMoney(event:PlayerPropertyEvent) : void
      {
         updateAccount();
      }
      
      private function __sellSortChange(e:AuctionHouseEvent) : void
      {
         _browse.searchByCurCondition(_model.sellCurrent,PlayerManager.Instance.Self.ID);
      }
      
      private function updateAccount() : void
      {
         _money.text = String(PlayerManager.Instance.Self.Money);
      }
      
      private function __getCategory(event:AuctionHouseEvent) : void
      {
         _model.browseCurrent = 1;
         _browse.setCategory(_model.category);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _model = null;
         _controller = null;
         if(_browse)
         {
            ObjectUtils.disposeObject(_browse);
         }
         _browse = null;
         if(_buy)
         {
            ObjectUtils.disposeObject(_buy);
         }
         _buy = null;
         if(_sell)
         {
            ObjectUtils.disposeObject(_sell);
         }
         _sell = null;
         if(_notesButton)
         {
            ObjectUtils.disposeObject(_notesButton);
         }
         _notesButton = null;
         if(_browse_btn)
         {
            ObjectUtils.disposeObject(_browse_btn);
         }
         _browse_btn = null;
         if(_buy_btn)
         {
            ObjectUtils.disposeObject(_buy_btn);
         }
         _buy_btn = null;
         if(_sell_btn)
         {
            ObjectUtils.disposeObject(_sell_btn);
         }
         _sell_btn = null;
         if(_money)
         {
            ObjectUtils.disposeObject(_money);
         }
         _money = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(moneyBG)
         {
            ObjectUtils.disposeObject(moneyBG);
         }
         moneyBG = null;
         if(moneyInfoBG)
         {
            ObjectUtils.disposeObject(moneyInfoBG);
         }
         moneyInfoBG = null;
         if(_titleBroweBtn)
         {
            ObjectUtils.disposeObject(_titleBroweBtn);
         }
         _titleBroweBtn = null;
         if(_titleBuyBtn)
         {
            ObjectUtils.disposeObject(_titleBuyBtn);
         }
         _titleBuyBtn = null;
         if(_explainTxt)
         {
            ObjectUtils.disposeObject(_explainTxt);
         }
         _explainTxt = null;
         if(_titleSellBtn)
         {
            ObjectUtils.disposeObject(_titleSellBtn);
         }
         _titleSellBtn = null;
         if(_moneyBitmap)
         {
            ObjectUtils.disposeObject(_moneyBitmap);
         }
         _moneyBitmap = null;
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
         }
         _btnGroup = null;
         if(_titleBG)
         {
            ObjectUtils.disposeObject(_titleBG);
         }
         _titleBG = null;
         if(_titleName)
         {
            ObjectUtils.disposeObject(_titleName);
         }
         _titleName = null;
      }
   }
}
