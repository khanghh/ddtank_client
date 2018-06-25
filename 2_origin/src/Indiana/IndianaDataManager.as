package Indiana
{
   import Indiana.analyzer.IndianaGoodsItemAnalyzer;
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.analyzer.IndianaShopItemsAnalyzer;
   import Indiana.event.IndianaEvent;
   import Indiana.model.HistoryIndianaData;
   import Indiana.model.IndianaData;
   import Indiana.model.IndianaModel;
   import Indiana.model.IndianaShowData;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hall.IHallStateView;
   import hallIcon.HallIconManager;
   import times.utils.timerManager.TimerJuggler;
   
   public class IndianaDataManager extends EventDispatcher
   {
      
      private static var _instance:IndianaDataManager;
       
      
      private var _model:IndianaModel;
      
      public var currentShowData:IndianaShowData;
      
      private var indianaDic:Vector.<IndianaData>;
      
      private var historyIndiana:Vector.<HistoryIndianaData>;
      
      private var beginCode:int;
      
      public var totleCount:int;
      
      private var joinCount:int;
      
      private var currentShopInfo:IndianaShopItemInfo;
      
      private var view;
      
      public var _showBtn:Boolean = false;
      
      private var _shopItems:Vector.<IndianaShowData>;
      
      private var _hall:IHallStateView;
      
      private var _icon:IndianaIcon;
      
      public var updataRecode:Boolean = false;
      
      private var _timer:TimerJuggler;
      
      public function IndianaDataManager(target:IEventDispatcher = null)
      {
         super(target);
         _model = new IndianaModel();
         indianaDic = new Vector.<IndianaData>();
         historyIndiana = new Vector.<HistoryIndianaData>();
         _shopItems = new Vector.<IndianaShowData>();
      }
      
      public static function get instance() : IndianaDataManager
      {
         if(!_instance)
         {
            _instance = new IndianaDataManager();
         }
         return _instance;
      }
      
      public function get model() : IndianaModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(385,IndianaEPackageType.ENTER_GAME),__enterGameHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(385,IndianaEPackageType.CURRENT_INDIANA_INFO),__currentIndianaInfoHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(385,IndianaEPackageType.HISTORY_INDIANA_INFO),__historyIndianaInfoHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(385,IndianaEPackageType.JOIN_HISTORY),__joinIndianaInfoHandler);
      }
      
      public function __joinIndianaInfoHandler(pkg:PkgEvent) : void
      {
         currentShowData.state = pkg.pkg.readInt();
         totleCount = pkg.pkg.readInt();
         currentShowData.buyNumber = totleCount;
         beginCode = pkg.pkg.readInt();
         joinCount = pkg.pkg.readInt();
         currentShowData.humanFullTime = pkg.pkg.readDate();
         currentShowData.joinCount = pkg.pkg.readInt();
         currentShowData.luckCode = pkg.pkg.readLong();
         currentShowData.annTime = pkg.pkg.readDate();
         currentShowData.useId = pkg.pkg.readInt();
         currentShowData.nickName = pkg.pkg.readUTF();
         currentShowData.buyTimes = pkg.pkg.readInt();
         currentShowData.areaId = pkg.pkg.readInt();
         currentShowData.areaName = pkg.pkg.readUTF();
         currentShowData.joinTime = pkg.pkg.readDate();
         if(currentShowData.state != 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("Indiana.buy.hasfull"));
         }
         if(view)
         {
            view.upData();
         }
      }
      
      private function __historyIndianaInfoHandler(pkg:PkgEvent) : void
      {
         var data:* = null;
         var a:int = 0;
         var i:int = 0;
         var len:int = historyIndiana.length;
         if(len > 0)
         {
            for(a = 0; a < len; )
            {
               historyIndiana[a] = null;
               a++;
            }
            historyIndiana.length = 0;
         }
         len = pkg.pkg.extend2;
         for(i = 0; i < len; )
         {
            data = new HistoryIndianaData();
            data.per_Id = pkg.pkg.readInt();
            data.per_name = pkg.pkg.readUTF();
            data.goodsId = pkg.pkg.readInt();
            data.goodsName = pkg.pkg.readUTF();
            data.campaign = pkg.pkg.readUTF();
            data.winningCode = pkg.pkg.readLong();
            data.AnnTime = pkg.pkg.readDate();
            data.useId = pkg.pkg.readInt();
            data.nickName = pkg.pkg.readUTF();
            data.joinCount = pkg.pkg.readInt();
            data.areaId = pkg.pkg.readInt();
            data.areaName = pkg.pkg.readUTF();
            historyIndiana.push(data);
            i++;
         }
         historyIndiana.reverse();
         dispatchEvent(new IndianaEvent("historyiteminfo"));
      }
      
      public function get HistoryIndianaInfo() : Vector.<HistoryIndianaData>
      {
         return historyIndiana;
      }
      
      private function __currentIndianaInfoHandler(pkg:PkgEvent) : void
      {
         var a:int = 0;
         var data:* = null;
         var i:int = 0;
         var len:int = indianaDic.length;
         for(a = 0; a < len; )
         {
            indianaDic[a] = null;
            a++;
         }
         indianaDic.length = 0;
         len = pkg.pkg.readInt();
         for(i = 0; i < len; )
         {
            data = new IndianaData();
            data.per_Id = pkg.pkg.readInt();
            data.per_name = pkg.pkg.readUTF();
            data.joinCount = pkg.pkg.readInt();
            data.joinTime = pkg.pkg.readUTF();
            data.useId = pkg.pkg.readInt();
            data.nickName = pkg.pkg.readUTF();
            data.areaId = pkg.pkg.readInt();
            data.areaName = pkg.pkg.readUTF();
            indianaDic.push(data);
            i++;
         }
         dispatchEvent(new IndianaEvent("recodeiteminfo"));
      }
      
      public function get currentIndianInfo() : Vector.<IndianaData>
      {
         return indianaDic;
      }
      
      private function __enterGameHandler(pkg:PkgEvent) : void
      {
         var perid:int = 0;
         var i:int = 0;
         var len:int = pkg.pkg.extend2;
         if(len == 0)
         {
            return;
         }
         i = 0;
         while(i < len)
         {
            perid = pkg.pkg.readInt();
            currentShowData = getIndianaShowDataByPerId(perid);
            if(currentShowData == null)
            {
               currentShowData = new IndianaShowData();
               _shopItems.push(currentShowData);
            }
            currentShowData.per_id = perid;
            currentShowData.state = pkg.pkg.readInt();
            var _loc5_:* = pkg.pkg.readInt();
            currentShowData.buyNumber = _loc5_;
            totleCount = _loc5_;
            currentShowData.joinCount = pkg.pkg.readInt();
            currentShowData.fulltime = pkg.pkg.readDate();
            currentShowData.luckCode = pkg.pkg.readLong();
            currentShowData.annTime = pkg.pkg.readDate();
            currentShowData.useId = pkg.pkg.readInt();
            currentShowData.nickName = pkg.pkg.readUTF();
            currentShowData.buyTimes = pkg.pkg.readInt();
            currentShowData.areaId = pkg.pkg.readInt();
            currentShowData.areaName = pkg.pkg.readUTF();
            currentShowData.joinTime = pkg.pkg.readDate();
            currentShowData.humanFullTime = pkg.pkg.readDate();
            i++;
         }
         if(len > 1)
         {
            sortShowData();
            currentShowData = _shopItems[0];
         }
         if(view == null)
         {
            SocketManager.Instance.out.sendUpdateSysDate();
            view = ComponentFactory.Instance.creatComponentByStylename("indianaMainView.Frame");
            view.show();
         }
         view.upData();
      }
      
      private function sortShowData() : void
      {
         var tempdata:* = null;
         var tempdataII:* = null;
         var tempshowdata:* = null;
         var j:* = 0;
         var k:* = 0;
         var len:int = _shopItems.length;
         var temp:Vector.<IndianaShowData> = _shopItems;
         _shopItems = new Vector.<IndianaShowData>();
         var doing:Vector.<IndianaShowData> = new Vector.<IndianaShowData>();
         var over:Vector.<IndianaShowData> = new Vector.<IndianaShowData>();
         var i:int = 0;
         i;
         while(i < len)
         {
            if(temp[i].state == IndianaModel.INDIANA_DOING)
            {
               doing.push(temp[i]);
            }
            else
            {
               over.push(temp[i]);
            }
            i++;
         }
         i = 0;
         len = doing.length;
         i;
         while(i < len)
         {
            for(j = i; j < len; )
            {
               tempdata = _model.getShopItemByid(doing[i].per_id);
               tempdataII = _model.getShopItemByid(doing[j].per_id);
               if(tempdata.Order > tempdataII.Order)
               {
                  tempshowdata = doing[i];
                  doing[i] = doing[j];
                  doing[j] = tempshowdata;
               }
               j++;
            }
            i++;
         }
         i = 0;
         len = over.length;
         i;
         while(i < len)
         {
            for(k = i; k < len; )
            {
               tempdata = _model.getShopItemByid(over[i].per_id);
               tempdataII = _model.getShopItemByid(over[k].per_id);
               if(tempdata.Order > tempdataII.Order)
               {
                  tempshowdata = over[i];
                  over[i] = over[k];
                  over[k] = tempshowdata;
               }
               k++;
            }
            i++;
         }
         len = doing.length;
         i = 0;
         i;
         while(i < len)
         {
            _shopItems.push(doing[i]);
            i++;
         }
         len = over.length;
         i = 0;
         i;
         while(i < len)
         {
            _shopItems.push(over[i]);
            i++;
         }
      }
      
      private function sortState(x:IndianaShowData, y:IndianaShowData) : int
      {
         if(x.state < y.state)
         {
            return -1;
         }
         if(x.state > y.state)
         {
            return 1;
         }
         return 0;
      }
      
      private function getIndianaShowDataByPerId(id:int) : IndianaShowData
      {
         var i:int = 0;
         var len:int = _shopItems.length;
         for(i = 0; i < len; )
         {
            if(_shopItems[i].per_id == id)
            {
               return _shopItems[i];
            }
            i++;
         }
         return null;
      }
      
      public function disposeView() : void
      {
         if(view)
         {
            view.dispose();
            view = null;
         }
      }
      
      public function goodsItemAnalyzer(analyzer:IndianaGoodsItemAnalyzer) : void
      {
         _model.Items = analyzer.data;
      }
      
      public function shopItemAnalyzer(analyzer:IndianaShopItemsAnalyzer) : void
      {
         _model.ShopItems = analyzer.data;
      }
      
      public function tickTime() : void
      {
         var state:int = _model.getActivateState();
         if(state > 0)
         {
            if(_showBtn == false && state == IndianaModel.INDIANA_START)
            {
               _showBtn = true;
            }
            if(_showBtn && state == IndianaModel.INDIANA_END)
            {
               _showBtn = false;
               disposeTimer();
            }
         }
         else if(_showBtn)
         {
            _showBtn = false;
            disposeTimer();
         }
         checkIcon();
      }
      
      public function checkIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("indiana",_showBtn);
      }
      
      private function disposeTimer() : void
      {
         if(!_timer)
         {
         }
      }
      
      private function __completeHander(evt:Event) : void
      {
         if(_showBtn)
         {
            _timer.reset();
            _timer.start();
         }
      }
      
      public function getTemplatesByShopId(shopId:int) : ItemTemplateInfo
      {
         var data:* = null;
         var info:IndianaGoodsItemInfo = getIndianaGoodsItemInfoByshopId(shopId);
         if(info)
         {
            data = ItemManager.Instance.getTemplateById(info.GoodsID);
         }
         return data;
      }
      
      public function getIndianaGoodsItemInfoByshopId(shopId:int) : IndianaGoodsItemInfo
      {
         var data:* = null;
         var i:int = 0;
         var len:int = _model.Items.length;
         for(i = 0; i < len; )
         {
            if(shopId == _model.Items[i].Id)
            {
               data = _model.Items[i];
               return data;
            }
            i++;
         }
         return data;
      }
      
      public function get getCurrentShopItem() : IndianaShopItemInfo
      {
         if(currentShowData)
         {
            currentShopInfo = _model.getShopItemByid(currentShowData.per_id);
         }
         return currentShopInfo;
      }
      
      public function get leftShopItem() : IndianaShowData
      {
         var index:int = 0;
         var data:* = null;
         if(currentShowData)
         {
            index = _shopItems.indexOf(currentShowData);
            if(index > 0)
            {
               index--;
               data = _shopItems[index];
            }
            else
            {
               data = _shopItems[_shopItems.length - 1];
            }
            return data;
         }
         return null;
      }
      
      public function get rightShopItem() : IndianaShowData
      {
         var index:int = 0;
         var data:* = null;
         if(currentShowData)
         {
            index = _shopItems.indexOf(currentShowData);
            if(index < _shopItems.length - 1)
            {
               index++;
               data = _shopItems[index];
            }
            else
            {
               data = _shopItems[0];
            }
            return data;
         }
         return null;
      }
      
      public function getShopItem() : Array
      {
         var info:* = null;
         var i:int = 0;
         var arr:Array = [];
         var len:int = _shopItems.length;
         for(i = 0; i < len; )
         {
            info = _model.getShopItemByid(_shopItems[i].per_id);
            if(info && info.Putaway == 1)
            {
               arr.push(info);
            }
            i++;
         }
         return arr;
      }
      
      private function onComplete() : void
      {
         if(_model.ShopItems.length > 0)
         {
            SocketManager.Instance.out.sendUpdateSysDate();
            SocketManager.Instance.out.sendIndianaEnterGame(0);
         }
      }
      
      public function show() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createHorsePicCherishDataLoader());
         AssetModuleLoader.addModelLoader("indiana",6);
         AssetModuleLoader.startCodeLoader(onComplete);
      }
   }
}
