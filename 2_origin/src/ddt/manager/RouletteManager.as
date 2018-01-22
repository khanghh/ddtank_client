package ddt.manager
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.action.FunctionAction;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.command.QuickBuyFrame;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.caddyII.CaddyAwardListFrame;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyFrame;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.card.CardFrame;
   import ddt.view.caddyII.card.CardSoulBoxFrame;
   import ddt.view.caddyII.vip.VipBoxFrame;
   import ddt.view.roulette.RouletteBoxPanel;
   import ddt.view.roulette.RouletteEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   public class RouletteManager extends EventDispatcher
   {
      
      private static var _instance:RouletteManager = null;
      
      public static const SLEEP:int = 0;
      
      public static const OPEN_ROULETTEBOX:int = 1;
      
      public static const OPEN_CADDY:int = 2;
      
      public static const NO_BOX:int = 0;
      
      public static const ROULETTEBOX:int = 1;
      
      public static const CADDY:int = 2;
       
      
      private var _rouletteBoxkeyCount:int = -1;
      
      private var _caddyKeyCount:int = -1;
      
      private var _templateIDList:Array;
      
      private var _bagType:int;
      
      private var _place:int;
      
      private var _stateAfterBuyKey:int = 0;
      
      private var _boxType:int = 0;
      
      private var _numList:Array;
      
      public var dataList:Vector.<Object>;
      
      public var goodList:Vector.<InventoryItemInfo>;
      
      private var _goodsInfo:ItemTemplateInfo;
      
      private var limdataList:Vector.<Object>;
      
      public function RouletteManager(param1:IEventDispatcher = null)
      {
         _numList = [0,0,0,4,4,4,3,3,3,2];
         super(param1);
      }
      
      public static function get instance() : RouletteManager
      {
         if(_instance == null)
         {
            _instance = new RouletteManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _templateIDList = [];
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_bagUpdate);
         SocketManager.Instance.addEventListener(PkgEvent.format(45),__getBadLuckHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(29),_showBox);
         SocketManager.Instance.addEventListener(PkgEvent.format(97),luckStoneRankLimit);
      }
      
      protected function luckStoneRankLimit(param1:PkgEvent) : void
      {
         var _loc13_:* = null;
         var _loc3_:* = null;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         var _loc5_:* = null;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         limdataList = new Vector.<Object>();
         var _loc7_:PackageIn = param1.pkg;
         var _loc4_:Boolean = _loc7_.readBoolean();
         if(_loc4_)
         {
            _loc12_ = _loc7_.readInt();
            _loc8_ = 0;
            while(_loc8_ < _loc12_)
            {
               _loc13_ = {};
               _loc11_ = _loc7_.readInt();
               if(_loc11_ == 2)
               {
                  _loc13_.TemplateID1 = _loc7_.readInt();
               }
               _loc13_.TemplateID = _loc7_.readInt();
               _loc13_.count = _numList[_loc8_];
               limdataList.push(_loc13_);
               _loc8_++;
            }
            _loc3_ = new CaddyEvent("luckstone_rank_limit");
            _loc3_.lastTime = _loc5_;
            _loc3_.dataList = limdataList;
            dispatchEvent(_loc3_);
            return;
         }
         _loc5_ = _loc7_.readUTF();
         var _loc9_:Boolean = _loc7_.readBoolean();
         var _loc2_:int = _loc7_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc2_)
         {
            _loc13_ = {};
            _loc13_["Rank"] = _loc7_.readInt();
            _loc13_["UserID"] = _loc7_.readInt();
            _loc13_["LuckStone"] = _loc7_.readInt();
            _loc6_ = _loc7_.readInt();
            if(_loc6_ == 2)
            {
               _loc13_["TemplateID1"] = _loc7_.readInt();
            }
            _loc13_["TemplateID"] = _loc7_.readInt();
            _loc13_["Nickname"] = _loc7_.readUTF();
            _loc13_["count"] = _numList[_loc10_];
            limdataList.push(_loc13_);
            _loc10_++;
         }
         _loc3_ = new CaddyEvent("luckstone_rank_limit");
         _loc3_.lastTime = _loc5_;
         _loc3_.dataList = limdataList;
         dispatchEvent(_loc3_);
      }
      
      private function _showBox(param1:PkgEvent) : void
      {
         switch(int(_boxType) - 1)
         {
            case 0:
               _showRoultteView(param1);
            default:
               _showRoultteView(param1);
         }
      }
      
      private function _showRoultteView(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:PackageIn = param1.pkg;
         _loc4_ = 0;
         while(_loc4_ < 18)
         {
            try
            {
               _loc3_ = new BoxGoodsTempInfo();
               _loc3_.TemplateId = _loc2_.readInt();
               _loc3_.IsBind = _loc2_.readBoolean();
               _loc3_.ItemCount = _loc2_.readByte();
               _loc3_.ItemValid = _loc2_.readByte();
               _templateIDList.push(_loc3_);
            }
            catch(e:Error)
            {
            }
            _loc4_++;
         }
         _randomTemplateID();
         showRouletteView();
         _boxType = 0;
      }
      
      public function useVipBox(param1:BagCell) : void
      {
         _goodsInfo = param1.info;
         var _loc2_:VipBoxFrame = ComponentFactory.Instance.creatCustomObject("caddyII.VipFrame",[13,_goodsInfo]);
         _loc2_.setCardType(param1.info.TemplateID,param1.place);
         _loc2_.show();
         _boxType = 0;
      }
      
      public function useRouletteBox(param1:BagCell) : void
      {
         _rouletteBoxkeyCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112109);
         _bagType = param1.itemInfo.BagType;
         _place = param1.itemInfo.Place;
         _boxType = 1;
         SocketManager.Instance.out.sendRouletteBox(_bagType,_place);
      }
      
      private function updateState() : void
      {
         switch(int(_stateAfterBuyKey))
         {
            case 0:
               break;
            case 1:
               if(_rouletteBoxkeyCount >= 1)
               {
                  SocketManager.Instance.out.sendRouletteBox(_bagType,_place);
               }
               _stateAfterBuyKey = 0;
               break;
            case 2:
         }
      }
      
      public function showRouletteView() : void
      {
         var _loc1_:RouletteBoxPanel = ComponentFactory.Instance.creat("roulette.RoulettePanelAsset");
         _loc1_.templateIDList = _templateIDList;
         _loc1_.keyCount = _rouletteBoxkeyCount;
         _loc1_.show();
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function showBuyRouletteKey(param1:int) : void
      {
         var _loc2_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc2_.itemID = 112109;
         _loc2_.stoneNumber = param1;
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
         _loc2_.addEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as QuickBuyFrame).removeEventListener("response",_response);
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            _closeFun();
         }
      }
      
      private function _closeFun() : void
      {
         _stateAfterBuyKey = 0;
      }
      
      private function _randomTemplateID() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:BoxGoodsTempInfo = null;
         _loc3_ = 0;
         while(_loc3_ < _templateIDList.length)
         {
            _loc2_ = Math.floor(Math.random() * _templateIDList.length);
            _loc1_ = _templateIDList[_loc3_] as BoxGoodsTempInfo;
            _templateIDList[_loc3_] = _templateIDList[_loc2_];
            _templateIDList[_loc2_] = _loc1_;
            _loc3_++;
         }
      }
      
      private function _bagUpdate(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112109);
         if(_rouletteBoxkeyCount != _loc3_)
         {
            _loc2_ = new RouletteEvent("roulette_key_count_update");
            _rouletteBoxkeyCount = _loc3_;
            _loc2_.keyCount = _loc3_;
            dispatchEvent(_loc2_);
            updateState();
         }
      }
      
      private function __getBadLuckHandler(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = null;
         dataList = new Vector.<Object>();
         var _loc5_:PackageIn = param1.pkg;
         var _loc4_:String = _loc5_.readUTF();
         var _loc8_:Boolean = _loc5_.readBoolean();
         var _loc2_:int = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc6_ = {};
            _loc6_["Rank"] = _loc5_.readInt();
            _loc6_["UserID"] = _loc5_.readInt();
            _loc6_["Count"] = _loc5_.readInt();
            _loc6_["TemplateID"] = _loc5_.readInt();
            _loc6_["Nickname"] = _loc5_.readUTF();
            dataList.push(_loc6_);
            _loc7_++;
         }
         if(_loc2_ == 0 || dataList[0].TemplateID == 0)
         {
            _loc3_ = new CaddyEvent("update_badLuck");
            _loc3_.lastTime = _loc4_;
            _loc3_.dataList = dataList;
            dispatchEvent(_loc3_);
         }
         else if(_loc8_)
         {
            if(getStateAble(StateManager.currentStateType))
            {
               __showBadLuckEndFrame();
            }
            else
            {
               CacheSysManager.getInstance().cacheFunction("alertInHall",new FunctionAction(__showBadLuckEndFrame));
            }
         }
      }
      
      private function __showBadLuckEndFrame() : void
      {
         var _loc1_:CaddyAwardListFrame = ComponentFactory.Instance.creatComponentByStylename("caddyAwardListFrame");
         LayerManager.Instance.addToLayer(_loc1_,2,true,0);
      }
      
      private function getStateAble(param1:String) : Boolean
      {
         if(param1 == "main" || param1 == "auction" || param1 == "ddtchurchroomlist" || param1 == "roomlist" || param1 == "consortia" || param1 == "dungeon" || param1 == "hotSpringRoomList" || param1 == "fightLib" || param1 == "academyRegistration" || param1 == "civil" || param1 == "tofflist")
         {
            return true;
         }
         return false;
      }
      
      public function useCaddy(param1:BagCell) : void
      {
         _goodsInfo = param1.info;
         try
         {
            _creatCaddy();
            return;
         }
         catch(e:Error)
         {
            _loadSWF();
            return;
         }
      }
      
      private function _creatCaddy() : void
      {
         var _loc1_:CaddyFrame = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[1,_goodsInfo]);
         _loc1_.show();
         _boxType = 0;
      }
      
      public function useBless(param1:BagCell = null) : void
      {
         if(!param1)
         {
            _goodsInfo = ItemManager.Instance.getTemplateById(112222);
         }
         else
         {
            _goodsInfo = param1.info;
         }
         try
         {
            _creatBless();
            return;
         }
         catch(event:Error)
         {
            _loadUI();
            return;
         }
      }
      
      private function _creatBless() : void
      {
         var _loc1_:CaddyFrame = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[10,_goodsInfo]);
         _loc1_.show();
      }
      
      public function useCelebrationBox() : void
      {
         var _loc1_:CaddyFrame = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[12]);
         _loc1_.show();
      }
      
      public function useBead(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 == 112150)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[8]);
         }
         else if(param1 == 112108)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("caddyIII.CardBoxFrame",[9]);
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[2]);
         }
         _loc2_.setBeadType(param1);
         _loc2_.show();
      }
      
      public function useOfferPack(param1:BagCell) : void
      {
         CaddyModel.instance.offerType = param1.info.TemplateID;
         var _loc2_:CaddyFrame = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[3]);
         _loc2_.setOfferType(param1.info.TemplateID);
         _loc2_.show();
      }
      
      public function useCard(param1:BagCell) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.info.TemplateID == 112108)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("caddy.CardFrame",[9]);
         }
         else if(param1.info.TemplateID == 112150)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("caddy.CardFrame",[8]);
         }
         else
         {
            if(param1.info.TemplateID == 20150)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("caddy.CardSoulBoxFrame",[6]);
               _loc2_.setCardType(param1.info.TemplateID,param1.place);
               _loc2_.show();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("caddy.CardFrame",[6]);
         }
         _loc3_.setCardType(param1.info.TemplateID,param1.place);
         _loc3_.show();
      }
      
      private function _loadSWF() : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onSmallLoadingClose);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIComplete);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onUIProgress);
         UIModuleLoader.Instance.addUIModuleImp("caddy");
      }
      
      private function _loadUI() : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onSmallLoadingClose);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUICompleteOne);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onUIProgress);
         UIModuleLoader.Instance.addUIModuleImp("caddy");
      }
      
      private function __onUIComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "caddy")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
            UIModuleSmallLoading.Instance.hide();
            _creatCaddy();
         }
      }
      
      private function __onUICompleteOne(param1:UIModuleEvent) : void
      {
         if(param1.module == "caddy")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
            UIModuleSmallLoading.Instance.hide();
            _creatBless();
         }
      }
      
      private function __onSmallLoadingClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
      }
      
      private function __onUIProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "caddy")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
   }
}
