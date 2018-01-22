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
      
      public function IndianaDataManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      public function __joinIndianaInfoHandler(param1:PkgEvent) : void
      {
         currentShowData.state = param1.pkg.readInt();
         totleCount = param1.pkg.readInt();
         currentShowData.buyNumber = totleCount;
         beginCode = param1.pkg.readInt();
         joinCount = param1.pkg.readInt();
         currentShowData.humanFullTime = param1.pkg.readDate();
         currentShowData.joinCount = param1.pkg.readInt();
         currentShowData.luckCode = param1.pkg.readLong();
         currentShowData.annTime = param1.pkg.readDate();
         currentShowData.useId = param1.pkg.readInt();
         currentShowData.nickName = param1.pkg.readUTF();
         currentShowData.buyTimes = param1.pkg.readInt();
         currentShowData.areaId = param1.pkg.readInt();
         currentShowData.areaName = param1.pkg.readUTF();
         currentShowData.joinTime = param1.pkg.readDate();
         if(currentShowData.state != 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("Indiana.buy.hasfull"));
         }
         if(view)
         {
            view.upData();
         }
      }
      
      private function __historyIndianaInfoHandler(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = historyIndiana.length;
         if(_loc4_ > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               historyIndiana[_loc2_] = null;
               _loc2_++;
            }
            historyIndiana.length = 0;
         }
         _loc4_ = param1.pkg.extend2;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = new HistoryIndianaData();
            _loc3_.per_Id = param1.pkg.readInt();
            _loc3_.per_name = param1.pkg.readUTF();
            _loc3_.goodsId = param1.pkg.readInt();
            _loc3_.goodsName = param1.pkg.readUTF();
            _loc3_.campaign = param1.pkg.readUTF();
            _loc3_.winningCode = param1.pkg.readLong();
            _loc3_.AnnTime = param1.pkg.readDate();
            _loc3_.useId = param1.pkg.readInt();
            _loc3_.nickName = param1.pkg.readUTF();
            _loc3_.joinCount = param1.pkg.readInt();
            _loc3_.areaId = param1.pkg.readInt();
            _loc3_.areaName = param1.pkg.readUTF();
            historyIndiana.push(_loc3_);
            _loc5_++;
         }
         historyIndiana.reverse();
         dispatchEvent(new IndianaEvent("historyiteminfo"));
      }
      
      public function get HistoryIndianaInfo() : Vector.<HistoryIndianaData>
      {
         return historyIndiana;
      }
      
      private function __currentIndianaInfoHandler(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:int = indianaDic.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            indianaDic[_loc2_] = null;
            _loc2_++;
         }
         indianaDic.length = 0;
         _loc4_ = param1.pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = new IndianaData();
            _loc3_.per_Id = param1.pkg.readInt();
            _loc3_.per_name = param1.pkg.readUTF();
            _loc3_.joinCount = param1.pkg.readInt();
            _loc3_.joinTime = param1.pkg.readUTF();
            _loc3_.useId = param1.pkg.readInt();
            _loc3_.nickName = param1.pkg.readUTF();
            _loc3_.areaId = param1.pkg.readInt();
            _loc3_.areaName = param1.pkg.readUTF();
            indianaDic.push(_loc3_);
            _loc5_++;
         }
         dispatchEvent(new IndianaEvent("recodeiteminfo"));
      }
      
      public function get currentIndianInfo() : Vector.<IndianaData>
      {
         return indianaDic;
      }
      
      private function __enterGameHandler(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = param1.pkg.extend2;
         if(_loc2_ == 0)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1.pkg.readInt();
            currentShowData = getIndianaShowDataByPerId(_loc3_);
            if(currentShowData == null)
            {
               currentShowData = new IndianaShowData();
               _shopItems.push(currentShowData);
            }
            currentShowData.per_id = _loc3_;
            currentShowData.state = param1.pkg.readInt();
            var _loc5_:* = param1.pkg.readInt();
            currentShowData.buyNumber = _loc5_;
            totleCount = _loc5_;
            currentShowData.joinCount = param1.pkg.readInt();
            currentShowData.fulltime = param1.pkg.readDate();
            currentShowData.luckCode = param1.pkg.readLong();
            currentShowData.annTime = param1.pkg.readDate();
            currentShowData.useId = param1.pkg.readInt();
            currentShowData.nickName = param1.pkg.readUTF();
            currentShowData.buyTimes = param1.pkg.readInt();
            currentShowData.areaId = param1.pkg.readInt();
            currentShowData.areaName = param1.pkg.readUTF();
            currentShowData.joinTime = param1.pkg.readDate();
            currentShowData.humanFullTime = param1.pkg.readDate();
            _loc4_++;
         }
         if(_loc2_ > 1)
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
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc6_:* = 0;
         var _loc9_:* = 0;
         var _loc5_:int = _shopItems.length;
         var _loc4_:Vector.<IndianaShowData> = _shopItems;
         _shopItems = new Vector.<IndianaShowData>();
         var _loc3_:Vector.<IndianaShowData> = new Vector.<IndianaShowData>();
         var _loc1_:Vector.<IndianaShowData> = new Vector.<IndianaShowData>();
         var _loc10_:int = 0;
         _loc10_;
         while(_loc10_ < _loc5_)
         {
            if(_loc4_[_loc10_].state == IndianaModel.INDIANA_DOING)
            {
               _loc3_.push(_loc4_[_loc10_]);
            }
            else
            {
               _loc1_.push(_loc4_[_loc10_]);
            }
            _loc10_++;
         }
         _loc10_ = 0;
         _loc5_ = _loc3_.length;
         _loc10_;
         while(_loc10_ < _loc5_)
         {
            _loc6_ = _loc10_;
            while(_loc6_ < _loc5_)
            {
               _loc8_ = _model.getShopItemByid(_loc3_[_loc10_].per_id);
               _loc7_ = _model.getShopItemByid(_loc3_[_loc6_].per_id);
               if(_loc8_.Order > _loc7_.Order)
               {
                  _loc2_ = _loc3_[_loc10_];
                  _loc3_[_loc10_] = _loc3_[_loc6_];
                  _loc3_[_loc6_] = _loc2_;
               }
               _loc6_++;
            }
            _loc10_++;
         }
         _loc10_ = 0;
         _loc5_ = _loc1_.length;
         _loc10_;
         while(_loc10_ < _loc5_)
         {
            _loc9_ = _loc10_;
            while(_loc9_ < _loc5_)
            {
               _loc8_ = _model.getShopItemByid(_loc1_[_loc10_].per_id);
               _loc7_ = _model.getShopItemByid(_loc1_[_loc9_].per_id);
               if(_loc8_.Order > _loc7_.Order)
               {
                  _loc2_ = _loc1_[_loc10_];
                  _loc1_[_loc10_] = _loc1_[_loc9_];
                  _loc1_[_loc9_] = _loc2_;
               }
               _loc9_++;
            }
            _loc10_++;
         }
         _loc5_ = _loc3_.length;
         _loc10_ = 0;
         _loc10_;
         while(_loc10_ < _loc5_)
         {
            _shopItems.push(_loc3_[_loc10_]);
            _loc10_++;
         }
         _loc5_ = _loc1_.length;
         _loc10_ = 0;
         _loc10_;
         while(_loc10_ < _loc5_)
         {
            _shopItems.push(_loc1_[_loc10_]);
            _loc10_++;
         }
      }
      
      private function sortState(param1:IndianaShowData, param2:IndianaShowData) : int
      {
         if(param1.state < param2.state)
         {
            return -1;
         }
         if(param1.state > param2.state)
         {
            return 1;
         }
         return 0;
      }
      
      private function getIndianaShowDataByPerId(param1:int) : IndianaShowData
      {
         var _loc3_:int = 0;
         var _loc2_:int = _shopItems.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_shopItems[_loc3_].per_id == param1)
            {
               return _shopItems[_loc3_];
            }
            _loc3_++;
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
      
      public function goodsItemAnalyzer(param1:IndianaGoodsItemAnalyzer) : void
      {
         _model.Items = param1.data;
      }
      
      public function shopItemAnalyzer(param1:IndianaShopItemsAnalyzer) : void
      {
         _model.ShopItems = param1.data;
      }
      
      public function tickTime() : void
      {
         var _loc1_:int = _model.getActivateState();
         if(_loc1_ > 0)
         {
            if(_showBtn == false && _loc1_ == IndianaModel.INDIANA_START)
            {
               _showBtn = true;
            }
            if(_showBtn && _loc1_ == IndianaModel.INDIANA_END)
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
      
      private function __completeHander(param1:Event) : void
      {
         if(_showBtn)
         {
            _timer.reset();
            _timer.start();
         }
      }
      
      public function getTemplatesByShopId(param1:int) : ItemTemplateInfo
      {
         var _loc2_:* = null;
         var _loc3_:IndianaGoodsItemInfo = getIndianaGoodsItemInfoByshopId(param1);
         if(_loc3_)
         {
            _loc2_ = ItemManager.Instance.getTemplateById(_loc3_.GoodsID);
         }
         return _loc2_;
      }
      
      public function getIndianaGoodsItemInfoByshopId(param1:int) : IndianaGoodsItemInfo
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = _model.Items.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1 == _model.Items[_loc4_].Id)
            {
               _loc2_ = _model.Items[_loc4_];
               return _loc2_;
            }
            _loc4_++;
         }
         return _loc2_;
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
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(currentShowData)
         {
            _loc1_ = _shopItems.indexOf(currentShowData);
            if(_loc1_ > 0)
            {
               _loc1_--;
               _loc2_ = _shopItems[_loc1_];
            }
            else
            {
               _loc2_ = _shopItems[_shopItems.length - 1];
            }
            return _loc2_;
         }
         return null;
      }
      
      public function get rightShopItem() : IndianaShowData
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(currentShowData)
         {
            _loc1_ = _shopItems.indexOf(currentShowData);
            if(_loc1_ < _shopItems.length - 1)
            {
               _loc1_++;
               _loc2_ = _shopItems[_loc1_];
            }
            else
            {
               _loc2_ = _shopItems[0];
            }
            return _loc2_;
         }
         return null;
      }
      
      public function getShopItem() : Array
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = _shopItems.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _model.getShopItemByid(_shopItems[_loc3_].per_id);
            if(_loc4_ && _loc4_.Putaway == 1)
            {
               _loc1_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc1_;
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
