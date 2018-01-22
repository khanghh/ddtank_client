package treasure.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.view.UIModuleSmallLoading;
   import farm.FarmModelController;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import treasure.data.TreasureTempInfo;
   import treasure.events.TreasureEvents;
   import treasure.model.TreasureModel;
   
   public class TreasureManager extends EventDispatcher
   {
      
      private static var _instance:TreasureManager = null;
       
      
      private var _UILoadComplete:Boolean = false;
      
      public function TreasureManager()
      {
         super();
         initEvent();
      }
      
      public static function get instance() : TreasureManager
      {
         if(_instance == null)
         {
            _instance = new TreasureManager();
         }
         return _instance;
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("enterTreasure",__onEnterTreasure);
         SocketManager.Instance.addEventListener("beRepairFriendFarmSend",__farmBeRepairHandler);
         SocketManager.Instance.addEventListener("stratGameTreasure",__stratGameHandler);
         SocketManager.Instance.addEventListener("endTreasure",__endGameHandler);
         SocketManager.Instance.addEventListener("dig",__digHandler);
      }
      
      private function __digHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = param1.pkg.readInt();
         var _loc6_:int = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         PlayerManager.Instance.Self.treasure = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         PlayerManager.Instance.Self.treasureAdd = _loc3_ > 0?_loc3_:0;
         _loc5_ = 0;
         while(_loc5_ < TreasureModel.instance.itemList.length)
         {
            if(TreasureModel.instance.itemList[_loc5_].TemplateID == _loc2_ && TreasureModel.instance.itemList[_loc5_].Count == _loc4_)
            {
               TreasureModel.instance.itemList[_loc5_].pos = _loc6_;
               sortList();
               dispatchEvent(new TreasureEvents("dig",{"pos":_loc6_}));
               return;
            }
            _loc5_++;
         }
      }
      
      private function __endGameHandler(param1:CrazyTankSocketEvent) : void
      {
         TreasureModel.instance.isEndTreasure = param1.pkg.readBoolean();
         dispatchEvent(new TreasureEvents("endGame"));
      }
      
      private function __stratGameHandler(param1:CrazyTankSocketEvent) : void
      {
         TreasureModel.instance.isBeginTreasure = param1.pkg.readBoolean();
         dispatchEvent(new TreasureEvents("beginGame"));
      }
      
      private function __farmBeRepairHandler(param1:CrazyTankSocketEvent) : void
      {
         TreasureModel.instance.friendHelpTimes = param1.pkg.readInt();
         if(TreasureModel.instance.friendHelpTimes == PathManager.treasureHelpTimes)
         {
            PlayerManager.Instance.Self.treasureAdd = 1;
         }
         dispatchEvent(new TreasureEvents("beRepairFriendFarmSend"));
      }
      
      private function __onEnterTreasure(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         TreasureModel.instance.logoinDays = param1.pkg.readInt();
         PlayerManager.Instance.Self.treasure = param1.pkg.readInt();
         var _loc8_:int = param1.pkg.readInt();
         PlayerManager.Instance.Self.treasureAdd = _loc8_ > 0?_loc8_:0;
         TreasureModel.instance.friendHelpTimes = param1.pkg.readInt();
         TreasureModel.instance.isEndTreasure = param1.pkg.readBoolean();
         TreasureModel.instance.isBeginTreasure = param1.pkg.readBoolean();
         TreasureModel.instance.itemList = new Vector.<TreasureTempInfo>();
         _loc3_ = param1.pkg.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc3_)
         {
            _loc7_ = new ItemTemplateInfo();
            _loc7_.TemplateID = param1.pkg.readInt();
            _loc7_ = ItemManager.Instance.getTemplateById(_loc7_.TemplateID);
            _loc6_ = new TreasureTempInfo();
            ObjectUtils.copyProperties(_loc6_,_loc7_);
            _loc6_.ValidDate = param1.pkg.readInt();
            _loc6_.Count = param1.pkg.readInt();
            _loc6_.pos = 0;
            _loc6_.IsBinds = true;
            _loc6_.BindType = 1;
            if(TreasureModel.instance.itemList.length == 0)
            {
               _loc4_ = 0;
            }
            else
            {
               _loc4_ = Math.floor((TreasureModel.instance.itemList.length + 1) * Math.random());
            }
            TreasureModel.instance.itemList.splice(_loc4_,0,_loc6_);
            _loc9_++;
         }
         _loc3_ = param1.pkg.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc3_)
         {
            _loc5_ = new ItemTemplateInfo();
            _loc5_.TemplateID = param1.pkg.readInt();
            _loc5_ = ItemManager.Instance.getTemplateById(_loc5_.TemplateID);
            _loc2_ = new TreasureTempInfo();
            ObjectUtils.copyProperties(_loc2_,_loc5_);
            _loc2_.pos = param1.pkg.readInt();
            _loc2_.ValidDate = param1.pkg.readInt();
            _loc2_.Count = param1.pkg.readInt();
            _loc2_.IsBinds = true;
            _loc2_.BindType = 1;
            TreasureModel.instance.itemList.push(_loc2_);
            _loc9_++;
         }
         sortList();
         if(_UILoadComplete)
         {
            creatView();
         }
         else
         {
            loadUIModule();
         }
      }
      
      private function sortList() : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc1_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < TreasureModel.instance.itemList.length)
         {
            if(TreasureModel.instance.itemList[_loc7_].pos != 0)
            {
               _loc1_.push({"pos":TreasureModel.instance.itemList[_loc7_].pos});
            }
            _loc7_++;
         }
         _loc4_ = 0;
         while(_loc4_ < TreasureModel.instance.itemList.length - 1)
         {
            _loc5_ = _loc4_ + 1;
            while(_loc5_ < TreasureModel.instance.itemList.length)
            {
               if(TreasureModel.instance.itemList[_loc4_].pos > TreasureModel.instance.itemList[_loc5_].pos)
               {
                  _loc3_ = TreasureModel.instance.itemList[_loc4_];
                  TreasureModel.instance.itemList[_loc4_] = TreasureModel.instance.itemList[_loc5_];
                  TreasureModel.instance.itemList[_loc5_] = _loc3_;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         var _loc2_:Vector.<TreasureTempInfo> = TreasureModel.instance.itemList.splice(TreasureModel.instance.itemList.length - _loc1_.length,_loc1_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            TreasureModel.instance.itemList.splice(_loc2_[_loc6_].pos - 1,0,_loc2_[_loc6_]);
            _loc6_++;
         }
      }
      
      private function creatView() : void
      {
         if(StateManager.currentStateType != "treasure")
         {
            StateManager.setState("treasure");
         }
         else
         {
            FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
         }
      }
      
      private function loadUIModule() : void
      {
         if(!_UILoadComplete)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
            UIModuleLoader.Instance.addUIModuleImp("treasure");
         }
      }
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
      }
      
      protected function __onUIModuleComplete(param1:UIModuleEvent) : void
      {
         _UILoadComplete = true;
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleSmallLoading.Instance.hide();
         creatView();
      }
      
      protected function __onProgress(param1:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
      }
      
      public function show() : void
      {
         SocketManager.Instance.out.enterTreasure();
      }
   }
}
