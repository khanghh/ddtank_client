package auctionHouse.view{   import auctionHouse.IAuctionHouse;   import auctionHouse.controller.AuctionHouseController;   import auctionHouse.event.AuctionHouseEvent;   import auctionHouse.model.AuctionHouseModel;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.auctionHouse.AuctionGoodsInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SharedManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import road7th.data.DictionaryEvent;      public class AuctionHouseView extends Sprite implements IAuctionHouse, Disposeable   {                   private var _model:AuctionHouseModel;            private var _controller:AuctionHouseController;            private var _isInit:Boolean;            private var _browse:AuctionBrowseView;            private var _buy:AuctionBuyView;            private var _sell:AuctionSellView;            private var _notesButton:BaseButton;            private var _titleMc:ScaleFrameImage;            private var _browse_btn:BaseButton;            private var _buy_btn:BaseButton;            private var _sell_btn:BaseButton;            private var _money:FilterFrameText;            private var _ddtauction:MovieImage;            private var _ddtauctionView:MovieImage;            private var moneyBG:Bitmap;            private var moneyInfoBG:ScaleBitmapImage;            private var _titleBroweBtn:SelectedButton;            private var _titleSellBtn:SelectedButton;            private var _titleBuyBtn:SelectedButton;            private var _btnGroup:SelectedButtonGroup;            private var _moneyBitmap:Bitmap;            private var _titleBG:Bitmap;            private var _titleName:Bitmap;            private var _explainTxt:FilterFrameText;            public function AuctionHouseView(controller:AuctionHouseController, model:AuctionHouseModel) { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            public function forbidChangeState() : void { }
            public function allowChangeState() : void { }
            private function __browse(event:MouseEvent) : void { }
            private function __buy(event:MouseEvent) : void { }
            private function __sell(event:MouseEvent) : void { }
            private function __changeState(event:AuctionHouseEvent) : void { }
            private function update() : void { }
            public function show() : void { }
            public function hide() : void { }
            private function __updatePage(event:AuctionHouseEvent) : void { }
            private function __prePage(event:AuctionHouseEvent) : void { }
            private function __nextPage(event:AuctionHouseEvent) : void { }
            private function __addMyAuction(event:DictionaryEvent) : void { }
            private function __clearMyAuction(event:DictionaryEvent) : void { }
            private function __removeMyAuction(event:DictionaryEvent) : void { }
            private function __updateMyAuction(event:DictionaryEvent) : void { }
            private function __addBrowse(event:DictionaryEvent) : void { }
            private function __removeBrowse(event:DictionaryEvent) : void { }
            private function __updateBrowse(event:DictionaryEvent) : void { }
            private function __clearBrowse(event:DictionaryEvent) : void { }
            private function __browserTypeChange(event:AuctionHouseEvent) : void { }
            private function __addBuyAuction(event:DictionaryEvent) : void { }
            private function __removeBuyAuction(event:DictionaryEvent) : void { }
            private function __clearBuyAuction(event:DictionaryEvent) : void { }
            private function __updateBuyAuction(event:DictionaryEvent) : void { }
            private function __changeMoney(event:PlayerPropertyEvent) : void { }
            private function __sellSortChange(e:AuctionHouseEvent) : void { }
            private function updateAccount() : void { }
            private function __getCategory(event:AuctionHouseEvent) : void { }
            public function dispose() : void { }
   }}