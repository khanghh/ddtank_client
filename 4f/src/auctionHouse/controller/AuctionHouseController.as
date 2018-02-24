package auctionHouse.controller
{
   import auctionHouse.AuctionState;
   import auctionHouse.IAuctionHouse;
   import auctionHouse.analyze.AuctionAnalyzer;
   import auctionHouse.model.AuctionHouseModel;
   import auctionHouse.view.AuctionHouseView;
   import auctionHouse.view.AuctionRightView;
   import auctionHouse.view.SimpleLoading;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.utils.MD5;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.data.goods.CateCoryInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.MainToolBar;
   import flash.net.URLVariables;
   import quest.TaskManager;
   
   public class AuctionHouseController extends BaseStateView
   {
       
      
      private var _model:AuctionHouseModel;
      
      private var _view:IAuctionHouse;
      
      private var _rightView:AuctionRightView;
      
      public function AuctionHouseController(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      public function set model(param1:AuctionHouseModel) : void{}
      
      public function get model() : AuctionHouseModel{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      public function setState(param1:String) : void{}
      
      public function browseTypeChange(param1:CateCoryInfo, param2:int = -1) : void{}
      
      public function browseTypeChangeNull() : void{}
      
      override public function dispose() : void{}
      
      public function searchAuctionList(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:uint = 0, param8:String = "false", param9:String = "") : void{}
      
      private function startLoadAuctionInfo(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:uint = 0, param8:String = "false", param9:String = "") : void{}
      
      private function __searchResult(param1:AuctionAnalyzer) : void{}
      
      private function __updateAuction(param1:PkgEvent) : void{}
      
      public function visibleHelp(param1:AuctionRightView, param2:int) : void{}
   }
}
