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
      
      public function RouletteManager(target:IEventDispatcher = null)
      {
         _numList = [0,0,0,4,4,4,3,3,3,2];
         super(target);
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
      
      protected function luckStoneRankLimit(event:PkgEvent) : void
      {
         var obj:* = null;
         var events:* = null;
         var count1:int = 0;
         var j:int = 0;
         var num:int = 0;
         var lastTime:* = null;
         var i:int = 0;
         var n:int = 0;
         limdataList = new Vector.<Object>();
         var pkg:PackageIn = event.pkg;
         var isStart:Boolean = pkg.readBoolean();
         if(isStart)
         {
            count1 = pkg.readInt();
            for(j = 0; j < count1; )
            {
               obj = {};
               num = pkg.readInt();
               if(num == 2)
               {
                  obj.TemplateID1 = pkg.readInt();
               }
               obj.TemplateID = pkg.readInt();
               obj.count = _numList[j];
               limdataList.push(obj);
               j++;
            }
            events = new CaddyEvent("luckstone_rank_limit");
            events.lastTime = lastTime;
            events.dataList = limdataList;
            dispatchEvent(events);
            return;
         }
         lastTime = pkg.readUTF();
         var isOpen:Boolean = pkg.readBoolean();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            obj = {};
            obj["Rank"] = pkg.readInt();
            obj["UserID"] = pkg.readInt();
            obj["LuckStone"] = pkg.readInt();
            n = pkg.readInt();
            if(n == 2)
            {
               obj["TemplateID1"] = pkg.readInt();
            }
            obj["TemplateID"] = pkg.readInt();
            obj["Nickname"] = pkg.readUTF();
            obj["count"] = _numList[i];
            limdataList.push(obj);
            i++;
         }
         events = new CaddyEvent("luckstone_rank_limit");
         events.lastTime = lastTime;
         events.dataList = limdataList;
         dispatchEvent(events);
      }
      
      private function _showBox(evt:PkgEvent) : void
      {
         switch(int(_boxType) - 1)
         {
            case 0:
               _showRoultteView(evt);
            default:
               _showRoultteView(evt);
         }
      }
      
      private function _showRoultteView(evt:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var pkg:PackageIn = evt.pkg;
         for(i = 0; i < 18; )
         {
            try
            {
               info = new BoxGoodsTempInfo();
               info.TemplateId = pkg.readInt();
               info.IsBind = pkg.readBoolean();
               info.ItemCount = pkg.readByte();
               info.ItemValid = pkg.readByte();
               _templateIDList.push(info);
            }
            catch(e:Error)
            {
            }
            i++;
         }
         _randomTemplateID();
         showRouletteView();
         _boxType = 0;
      }
      
      public function useVipBox(cell:BagCell) : void
      {
         _goodsInfo = cell.info;
         var panel:VipBoxFrame = ComponentFactory.Instance.creatCustomObject("caddyII.VipFrame",[13,_goodsInfo]);
         panel.setCardType(cell.info.TemplateID,cell.place);
         panel.show();
         _boxType = 0;
      }
      
      public function useRouletteBox(cell:BagCell) : void
      {
         _rouletteBoxkeyCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112109);
         _bagType = cell.itemInfo.BagType;
         _place = cell.itemInfo.Place;
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
         var panel:RouletteBoxPanel = ComponentFactory.Instance.creat("roulette.RoulettePanelAsset");
         panel.templateIDList = _templateIDList;
         panel.keyCount = _rouletteBoxkeyCount;
         panel.show();
         LayerManager.Instance.addToLayer(panel,3,true,1);
      }
      
      public function showBuyRouletteKey(needKeyCount:int) : void
      {
         var _quick:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 112109;
         _quick.stoneNumber = needKeyCount;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
         _quick.addEventListener("response",_response);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         (evt.currentTarget as QuickBuyFrame).removeEventListener("response",_response);
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
         var i:int = 0;
         var ran:int = 0;
         var itemID:BoxGoodsTempInfo = null;
         for(i = 0; i < _templateIDList.length; )
         {
            ran = Math.floor(Math.random() * _templateIDList.length);
            itemID = _templateIDList[i] as BoxGoodsTempInfo;
            _templateIDList[i] = _templateIDList[ran];
            _templateIDList[ran] = itemID;
            i++;
         }
      }
      
      private function _bagUpdate(e:BagEvent) : void
      {
         var evt:* = null;
         var number:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112109);
         if(_rouletteBoxkeyCount != number)
         {
            evt = new RouletteEvent("roulette_key_count_update");
            _rouletteBoxkeyCount = number;
            evt.keyCount = number;
            dispatchEvent(evt);
            updateState();
         }
      }
      
      private function __getBadLuckHandler(e:PkgEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         var events:* = null;
         dataList = new Vector.<Object>();
         var pkg:PackageIn = e.pkg;
         var lastTime:String = pkg.readUTF();
         var isOpen:Boolean = pkg.readBoolean();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            obj = {};
            obj["Rank"] = pkg.readInt();
            obj["UserID"] = pkg.readInt();
            obj["Count"] = pkg.readInt();
            obj["TemplateID"] = pkg.readInt();
            obj["Nickname"] = pkg.readUTF();
            dataList.push(obj);
            i++;
         }
         if(count == 0 || dataList[0].TemplateID == 0)
         {
            events = new CaddyEvent("update_badLuck");
            events.lastTime = lastTime;
            events.dataList = dataList;
            dispatchEvent(events);
         }
         else if(isOpen)
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
         var _listView:CaddyAwardListFrame = ComponentFactory.Instance.creatComponentByStylename("caddyAwardListFrame");
         LayerManager.Instance.addToLayer(_listView,2,true,0);
      }
      
      private function getStateAble(type:String) : Boolean
      {
         if(type == "main" || type == "auction" || type == "ddtchurchroomlist" || type == "roomlist" || type == "consortia" || type == "dungeon" || type == "hotSpringRoomList" || type == "fightLib" || type == "academyRegistration" || type == "civil" || type == "tofflist")
         {
            return true;
         }
         return false;
      }
      
      public function useCaddy(cell:BagCell) : void
      {
         _goodsInfo = cell.info;
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
         var panel:CaddyFrame = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[1,_goodsInfo]);
         panel.show();
         _boxType = 0;
      }
      
      public function useBless(cell:BagCell = null) : void
      {
         if(!cell)
         {
            _goodsInfo = ItemManager.Instance.getTemplateById(112222);
         }
         else
         {
            _goodsInfo = cell.info;
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
         var panel:CaddyFrame = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[10,_goodsInfo]);
         panel.show();
      }
      
      public function useCelebrationBox() : void
      {
         var panel:CaddyFrame = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[12]);
         panel.show();
      }
      
      public function useBead(templateID:int) : void
      {
         var panel:* = null;
         if(templateID == 112150)
         {
            panel = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[8]);
         }
         else if(templateID == 112108)
         {
            panel = ComponentFactory.Instance.creatCustomObject("caddyIII.CardBoxFrame",[9]);
         }
         else
         {
            panel = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[2]);
         }
         panel.setBeadType(templateID);
         panel.show();
      }
      
      public function useOfferPack(cell:BagCell) : void
      {
         CaddyModel.instance.offerType = cell.info.TemplateID;
         var panel:CaddyFrame = ComponentFactory.Instance.creatCustomObject("caddyII.CaddyFrame",[3]);
         panel.setOfferType(cell.info.TemplateID);
         panel.show();
      }
      
      public function useCard(cell:BagCell) : void
      {
         var panel:* = null;
         var panel2:* = null;
         if(cell.info.TemplateID == 112108)
         {
            panel = ComponentFactory.Instance.creatCustomObject("caddy.CardFrame",[9]);
         }
         else if(cell.info.TemplateID == 112150)
         {
            panel = ComponentFactory.Instance.creatCustomObject("caddy.CardFrame",[8]);
         }
         else
         {
            if(cell.info.TemplateID == 20150)
            {
               panel2 = ComponentFactory.Instance.creatCustomObject("caddy.CardSoulBoxFrame",[6]);
               panel2.setCardType(cell.info.TemplateID,cell.place);
               panel2.show();
               return;
            }
            panel = ComponentFactory.Instance.creatCustomObject("caddy.CardFrame",[6]);
         }
         panel.setCardType(cell.info.TemplateID,cell.place);
         panel.show();
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
      
      private function __onUIComplete(e:UIModuleEvent) : void
      {
         if(e.module == "caddy")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
            UIModuleSmallLoading.Instance.hide();
            _creatCaddy();
         }
      }
      
      private function __onUICompleteOne(e:UIModuleEvent) : void
      {
         if(e.module == "caddy")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
            UIModuleSmallLoading.Instance.hide();
            _creatBless();
         }
      }
      
      private function __onSmallLoadingClose(e:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
      }
      
      private function __onUIProgress(e:UIModuleEvent) : void
      {
         if(e.module == "caddy")
         {
            UIModuleSmallLoading.Instance.progress = e.loader.progress * 100;
         }
      }
   }
}
