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
      
      public function AuctionHouseView(param1:AuctionHouseController, param2:AuctionHouseModel){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function forbidChangeState() : void{}
      
      public function allowChangeState() : void{}
      
      private function __browse(param1:MouseEvent) : void{}
      
      private function __buy(param1:MouseEvent) : void{}
      
      private function __sell(param1:MouseEvent) : void{}
      
      private function __changeState(param1:AuctionHouseEvent) : void{}
      
      private function update() : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      private function __updatePage(param1:AuctionHouseEvent) : void{}
      
      private function __prePage(param1:AuctionHouseEvent) : void{}
      
      private function __nextPage(param1:AuctionHouseEvent) : void{}
      
      private function __addMyAuction(param1:DictionaryEvent) : void{}
      
      private function __clearMyAuction(param1:DictionaryEvent) : void{}
      
      private function __removeMyAuction(param1:DictionaryEvent) : void{}
      
      private function __updateMyAuction(param1:DictionaryEvent) : void{}
      
      private function __addBrowse(param1:DictionaryEvent) : void{}
      
      private function __removeBrowse(param1:DictionaryEvent) : void{}
      
      private function __updateBrowse(param1:DictionaryEvent) : void{}
      
      private function __clearBrowse(param1:DictionaryEvent) : void{}
      
      private function __browserTypeChange(param1:AuctionHouseEvent) : void{}
      
      private function __addBuyAuction(param1:DictionaryEvent) : void{}
      
      private function __removeBuyAuction(param1:DictionaryEvent) : void{}
      
      private function __clearBuyAuction(param1:DictionaryEvent) : void{}
      
      private function __updateBuyAuction(param1:DictionaryEvent) : void{}
      
      private function __changeMoney(param1:PlayerPropertyEvent) : void{}
      
      private function __sellSortChange(param1:AuctionHouseEvent) : void{}
      
      private function updateAccount() : void{}
      
      private function __getCategory(param1:AuctionHouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
