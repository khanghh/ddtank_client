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
      
      public function AuctionHouseController()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _model = new AuctionHouseModel();
         _view = new AuctionHouseView(this,_model);
         _view.show();
         AuctionState.CURRENTSTATE = "browse";
         _model.category = ItemManager.Instance.categorys;
         MainToolBar.Instance.show();
         MainToolBar.Instance.setAuctionHouseState();
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(91) && TaskManager.instance.getQuestDataByID(466))
         {
            SocketManager.Instance.out.sendQuestCheck(466,1,0);
            SocketManager.Instance.out.syncWeakStep(91);
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(195),__updateAuction);
      }
      
      public function set model(param1:AuctionHouseModel) : void
      {
         _model = param1;
      }
      
      public function get model() : AuctionHouseModel
      {
         return _model;
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         super.leaving(param1);
         dispose();
         MainToolBar.Instance.hide();
         PlayerManager.Instance.Self.unlockAllBag();
         SocketManager.Instance.removeEventListener(PkgEvent.format(195),__updateAuction);
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "auction";
      }
      
      public function setState(param1:String) : void
      {
         _model.state = param1;
         AuctionState.CURRENTSTATE = param1;
      }
      
      public function browseTypeChange(param1:CateCoryInfo, param2:int = -1) : void
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            _loc3_ = _model.getCatecoryById(param2);
         }
         else
         {
            _loc3_ = param1;
         }
         _model.currentBrowseGoodInfo = _loc3_;
      }
      
      public function browseTypeChangeNull() : void
      {
         _model.currentBrowseGoodInfo = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_view)
         {
            _view.hide();
         }
         _view = null;
         if(_model)
         {
            _model.dispose();
         }
         _model = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function searchAuctionList(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:uint = 0, param8:String = "false", param9:String = "") : void
      {
         if(AuctionHouseModel.searchType == 1)
         {
            param2 = "";
         }
         startLoadAuctionInfo(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         (_view as AuctionHouseView).forbidChangeState();
      }
      
      private function startLoadAuctionInfo(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:uint = 0, param8:String = "false", param9:String = "") : void
      {
         var _loc11_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc11_["page"] = param1;
         _loc11_["name"] = param2;
         _loc11_["type"] = param3;
         _loc11_["pay"] = param4;
         _loc11_["userID"] = param5;
         _loc11_["buyID"] = param6;
         _loc11_["order"] = param7;
         _loc11_["sort"] = param8;
         _loc11_["Auctions"] = param9;
         _loc11_["selfid"] = PlayerManager.Instance.Self.ID;
         _loc11_["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         _loc11_["rnd"] = Math.random();
         var _loc10_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AuctionPageList.ashx"),6,_loc11_);
         _loc10_.loadErrorMessage = LanguageMgr.GetTranslation("tank.auctionHouse.controller.AuctionHouseListError");
         _loc10_.analyzer = new AuctionAnalyzer(__searchResult);
         LoadResourceManager.Instance.startLoad(_loc10_);
         mouseChildren = false;
         mouseEnabled = false;
         if(AuctionHouseModel._dimBooble == false)
         {
            SimpleLoading.instance.show();
         }
      }
      
      private function __searchResult(param1:AuctionAnalyzer) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         mouseChildren = true;
         mouseEnabled = true;
         if(!_view)
         {
            return;
         }
         SimpleLoading.instance.hide();
         var _loc2_:Vector.<AuctionGoodsInfo> = param1.list;
         if(_model.state == "sell")
         {
            _model.clearMyAuction();
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               _model.addMyAuction(_loc2_[_loc6_]);
               _loc6_++;
            }
            _model.sellTotal = param1.total;
         }
         else if(_model.state == "browse")
         {
            _model.clearBrowseAuctionData();
            if(_loc2_.length == 0 && AuctionHouseModel.searchType != 3)
            {
               if(AuctionHouseModel._dimBooble == false)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.controller.AuctionHouseController"));
               }
            }
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _model.addBrowseAuctionData(_loc2_[_loc4_]);
               _loc4_++;
            }
            _model.browseTotal = param1.total;
         }
         else if(_model.state == "buy")
         {
            _loc3_ = [];
            _model.clearBuyAuctionData();
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _model.addBuyAuctionData(_loc2_[_loc5_]);
               _loc3_.push(_loc2_[_loc5_].AuctionID);
               _loc5_++;
            }
            _model.buyTotal = param1.total;
            SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] = _loc3_;
            SharedManager.Instance.save();
         }
         (_view as AuctionHouseView).allowChangeState();
      }
      
      private function __updateAuction(param1:PkgEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc3_:* = null;
         param1.pkg.deCompress();
         var _loc5_:AuctionGoodsInfo = new AuctionGoodsInfo();
         _loc5_.AuctionID = param1.pkg.readInt();
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            _loc5_.AuctioneerID = param1.pkg.readInt();
            _loc5_.AuctioneerName = param1.pkg.readUTF();
            _loc5_.beginDateObj = param1.pkg.readDate();
            _loc5_.BuyerID = param1.pkg.readInt();
            _loc5_.BuyerName = param1.pkg.readUTF();
            _loc5_.ItemID = param1.pkg.readInt();
            _loc5_.Mouthful = param1.pkg.readInt();
            _loc5_.PayType = param1.pkg.readInt();
            _loc5_.Price = param1.pkg.readInt();
            _loc5_.Rise = param1.pkg.readInt();
            _loc5_.ValidDate = param1.pkg.readInt();
            _loc4_ = param1.pkg.readBoolean();
            if(_loc4_)
            {
               _loc3_ = new InventoryItemInfo();
               _loc3_.Count = param1.pkg.readInt();
               _loc3_.TemplateID = param1.pkg.readInt();
               _loc3_.AttackCompose = param1.pkg.readInt();
               _loc3_.DefendCompose = param1.pkg.readInt();
               _loc3_.AgilityCompose = param1.pkg.readInt();
               _loc3_.LuckCompose = param1.pkg.readInt();
               _loc3_.StrengthenLevel = param1.pkg.readInt();
               _loc3_.IsBinds = param1.pkg.readBoolean();
               _loc3_.IsJudge = param1.pkg.readBoolean();
               _loc3_.BeginDate = param1.pkg.readDateString();
               _loc3_.ValidDate = param1.pkg.readInt();
               _loc3_.Color = param1.pkg.readUTF();
               _loc3_.Skin = param1.pkg.readUTF();
               _loc3_.IsUsed = param1.pkg.readBoolean();
               _loc3_.Hole1 = param1.pkg.readInt();
               _loc3_.Hole2 = param1.pkg.readInt();
               _loc3_.Hole3 = param1.pkg.readInt();
               _loc3_.Hole4 = param1.pkg.readInt();
               _loc3_.Hole5 = param1.pkg.readInt();
               _loc3_.Hole6 = param1.pkg.readInt();
               _loc3_.Pic = param1.pkg.readUTF();
               _loc3_.RefineryLevel = param1.pkg.readInt();
               _loc3_.DiscolorValidDate = param1.pkg.readDateString();
               _loc3_.Hole5Level = param1.pkg.readByte();
               _loc3_.Hole5Exp = param1.pkg.readInt();
               _loc3_.Hole6Level = param1.pkg.readByte();
               _loc3_.Hole6Exp = param1.pkg.readInt();
               _loc3_.MagicLevel = param1.pkg.readInt();
               _loc3_.curExp = param1.pkg.readInt();
               ItemManager.fill(_loc3_);
               _loc5_.BagItemInfo = _loc3_;
               _model.sellTotal = _model.sellTotal + 1;
            }
            _model.addMyAuction(_loc5_);
         }
         else
         {
            _model.removeMyAuction(_loc5_);
         }
      }
      
      public function visibleHelp(param1:AuctionRightView, param2:int) : void
      {
         _rightView = param1;
      }
   }
}
