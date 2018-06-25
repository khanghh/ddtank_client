package auctionHouse.controller{   import auctionHouse.AuctionState;   import auctionHouse.IAuctionHouse;   import auctionHouse.analyze.AuctionAnalyzer;   import auctionHouse.model.AuctionHouseModel;   import auctionHouse.view.AuctionHouseView;   import auctionHouse.view.AuctionRightView;   import auctionHouse.view.SimpleLoading;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.utils.MD5;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.auctionHouse.AuctionGoodsInfo;   import ddt.data.goods.CateCoryInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.states.BaseStateView;   import ddt.utils.RequestVairableCreater;   import ddt.view.MainToolBar;   import flash.net.URLVariables;   import quest.TaskManager;      public class AuctionHouseController extends BaseStateView   {                   private var _model:AuctionHouseModel;            private var _view:IAuctionHouse;            private var _rightView:AuctionRightView;            public function AuctionHouseController() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            public function set model(mo:AuctionHouseModel) : void { }
            public function get model() : AuctionHouseModel { return null; }
            override public function leaving(next:BaseStateView) : void { }
            override public function getBackType() : String { return null; }
            override public function getType() : String { return null; }
            public function setState(value:String) : void { }
            public function browseTypeChange(info:CateCoryInfo, id:int = -1) : void { }
            public function browseTypeChangeNull() : void { }
            override public function dispose() : void { }
            public function searchAuctionList(page:int, name:String, type:int, pay:int, userID:int, buyId:int, sortIndex:uint = 0, sortBy:String = "false", Auctions:String = "") : void { }
            private function startLoadAuctionInfo(page:int, name:String, type:int, pay:int, userID:int, buyId:int, sortIndex:uint = 0, sortBy:String = "false", Auctions:String = "") : void { }
            private function __searchResult(action:AuctionAnalyzer) : void { }
            private function __updateAuction(event:PkgEvent) : void { }
            public function visibleHelp(rightView:AuctionRightView, frame:int) : void { }
   }}