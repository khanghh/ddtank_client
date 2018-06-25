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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
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
      
      public function set model(mo:AuctionHouseModel) : void
      {
         _model = mo;
      }
      
      public function get model() : AuctionHouseModel
      {
         return _model;
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         super.leaving(next);
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
      
      public function setState(value:String) : void
      {
         _model.state = value;
         AuctionState.CURRENTSTATE = value;
      }
      
      public function browseTypeChange(info:CateCoryInfo, id:int = -1) : void
      {
         var tempInfo:* = null;
         if(info == null)
         {
            tempInfo = _model.getCatecoryById(id);
         }
         else
         {
            tempInfo = info;
         }
         _model.currentBrowseGoodInfo = tempInfo;
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
      
      public function searchAuctionList(page:int, name:String, type:int, pay:int, userID:int, buyId:int, sortIndex:uint = 0, sortBy:String = "false", Auctions:String = "") : void
      {
         if(AuctionHouseModel.searchType == 1)
         {
            name = "";
         }
         startLoadAuctionInfo(page,name,type,pay,userID,buyId,sortIndex,sortBy,Auctions);
         (_view as AuctionHouseView).forbidChangeState();
      }
      
      private function startLoadAuctionInfo(page:int, name:String, type:int, pay:int, userID:int, buyId:int, sortIndex:uint = 0, sortBy:String = "false", Auctions:String = "") : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = page;
         args["name"] = name;
         args["type"] = type;
         args["pay"] = pay;
         args["userID"] = userID;
         args["buyID"] = buyId;
         args["order"] = sortIndex;
         args["sort"] = sortBy;
         args["Auctions"] = Auctions;
         args["selfid"] = PlayerManager.Instance.Self.ID;
         args["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AuctionPageList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.auctionHouse.controller.AuctionHouseListError");
         loader.analyzer = new AuctionAnalyzer(__searchResult);
         LoadResourceManager.Instance.startLoad(loader);
         mouseChildren = false;
         mouseEnabled = false;
         if(AuctionHouseModel._dimBooble == false)
         {
            SimpleLoading.instance.show();
         }
      }
      
      private function __searchResult(action:AuctionAnalyzer) : void
      {
         var i:int = 0;
         var j:int = 0;
         var auctionIDs:* = null;
         var k:int = 0;
         mouseChildren = true;
         mouseEnabled = true;
         if(!_view)
         {
            return;
         }
         SimpleLoading.instance.hide();
         var list:Vector.<AuctionGoodsInfo> = action.list;
         if(_model.state == "sell")
         {
            _model.clearMyAuction();
            for(i = 0; i < list.length; )
            {
               _model.addMyAuction(list[i]);
               i++;
            }
            _model.sellTotal = action.total;
         }
         else if(_model.state == "browse")
         {
            _model.clearBrowseAuctionData();
            if(list.length == 0 && AuctionHouseModel.searchType != 3)
            {
               if(AuctionHouseModel._dimBooble == false)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.controller.AuctionHouseController"));
               }
            }
            j = 0;
            while(j < list.length)
            {
               _model.addBrowseAuctionData(list[j]);
               j++;
            }
            _model.browseTotal = action.total;
         }
         else if(_model.state == "buy")
         {
            auctionIDs = [];
            _model.clearBuyAuctionData();
            for(k = 0; k < list.length; )
            {
               _model.addBuyAuctionData(list[k]);
               auctionIDs.push(list[k].AuctionID);
               k++;
            }
            _model.buyTotal = action.total;
            SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] = auctionIDs;
            SharedManager.Instance.save();
         }
         (_view as AuctionHouseView).allowChangeState();
      }
      
      private function __updateAuction(event:PkgEvent) : void
      {
         var item:Boolean = false;
         var bag:* = null;
         event.pkg.deCompress();
         var info:AuctionGoodsInfo = new AuctionGoodsInfo();
         info.AuctionID = event.pkg.readInt();
         var isExist:Boolean = event.pkg.readBoolean();
         if(isExist)
         {
            info.AuctioneerID = event.pkg.readInt();
            info.AuctioneerName = event.pkg.readUTF();
            info.beginDateObj = event.pkg.readDate();
            info.BuyerID = event.pkg.readInt();
            info.BuyerName = event.pkg.readUTF();
            info.ItemID = event.pkg.readInt();
            info.Mouthful = event.pkg.readInt();
            info.PayType = event.pkg.readInt();
            info.Price = event.pkg.readInt();
            info.Rise = event.pkg.readInt();
            info.ValidDate = event.pkg.readInt();
            item = event.pkg.readBoolean();
            if(item)
            {
               bag = new InventoryItemInfo();
               bag.Count = event.pkg.readInt();
               bag.TemplateID = event.pkg.readInt();
               bag.AttackCompose = event.pkg.readInt();
               bag.DefendCompose = event.pkg.readInt();
               bag.AgilityCompose = event.pkg.readInt();
               bag.LuckCompose = event.pkg.readInt();
               bag.StrengthenLevel = event.pkg.readInt();
               bag.IsBinds = event.pkg.readBoolean();
               bag.IsJudge = event.pkg.readBoolean();
               bag.BeginDate = event.pkg.readDateString();
               bag.ValidDate = event.pkg.readInt();
               bag.Color = event.pkg.readUTF();
               bag.Skin = event.pkg.readUTF();
               bag.IsUsed = event.pkg.readBoolean();
               bag.Hole1 = event.pkg.readInt();
               bag.Hole2 = event.pkg.readInt();
               bag.Hole3 = event.pkg.readInt();
               bag.Hole4 = event.pkg.readInt();
               bag.Hole5 = event.pkg.readInt();
               bag.Hole6 = event.pkg.readInt();
               bag.Pic = event.pkg.readUTF();
               bag.RefineryLevel = event.pkg.readInt();
               bag.DiscolorValidDate = event.pkg.readDateString();
               bag.Hole5Level = event.pkg.readByte();
               bag.Hole5Exp = event.pkg.readInt();
               bag.Hole6Level = event.pkg.readByte();
               bag.Hole6Exp = event.pkg.readInt();
               bag.MagicLevel = event.pkg.readInt();
               bag.curExp = event.pkg.readInt();
               ItemManager.fill(bag);
               info.BagItemInfo = bag;
               _model.sellTotal = _model.sellTotal + 1;
            }
            _model.addMyAuction(info);
         }
         else
         {
            _model.removeMyAuction(info);
         }
      }
      
      public function visibleHelp(rightView:AuctionRightView, frame:int) : void
      {
         _rightView = rightView;
      }
   }
}
