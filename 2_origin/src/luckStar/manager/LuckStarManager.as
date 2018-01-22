package luckStar.manager
{
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import luckStar.model.LuckStarModel;
   import road7th.comm.PackageIn;
   
   public class LuckStarManager extends CoreManager
   {
      
      private static var _instance:LuckStarManager;
      
      public static const LUCKSTAR_FRAMECLOSE:String = "luckstarframeclose";
      
      public static const UPDATE_REWARD:String = "updatereward";
      
      public static const ALLGOODSINFO:String = "allgoodsinfo";
      
      public static const TURNGOODSINFO:String = "turngoodsinfo";
      
      public static const OPEN_LUCKYSTARFRAME:String = "openluckystarframe";
      
      public static const LOADER_LUCKSTAR_ICON:String = "loaderluckstaricon";
       
      
      private var _model:LuckStarModel;
      
      private var _isOpen:Boolean;
      
      public var iteminfo:InventoryItemInfo;
      
      public var rewardMsg:Object;
      
      public function LuckStarManager()
      {
         super();
         _model = new LuckStarModel();
      }
      
      public static function get Instance() : LuckStarManager
      {
         if(_instance == null)
         {
            _instance = new LuckStarManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("luckystaropen",__onActivityOpen);
      }
      
      private function __onActivityOpen(param1:CrazyTankSocketEvent) : void
      {
         if(!_isOpen)
         {
            SocketManager.Instance.addEventListener("luckystarend",__onActivityEnd);
         }
         _isOpen = true;
         addEnterIcon();
      }
      
      private function __onActivityEnd(param1:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.removeEventListener("luckystarend",__onActivityEnd);
         _isOpen = false;
         disposeEnterIcon();
      }
      
      private function __onAllGoodsInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:* = null;
         var _loc6_:PackageIn = param1.pkg;
         _model.coins = _loc6_.readInt();
         _model.setActivityDate(_loc6_.readDate(),_loc6_.readDate());
         _model.minUseNum = _loc6_.readInt();
         var _loc4_:int = _loc6_.readInt();
         var _loc7_:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            _loc3_ = _loc6_.readInt();
            _loc8_ = getTemplateInfo(_loc3_);
            _loc8_.StrengthenLevel = _loc6_.readInt();
            _loc8_.Count = _loc6_.readInt();
            _loc8_.ValidDate = _loc6_.readInt();
            _loc8_.AttackCompose = _loc6_.readInt();
            _loc8_.DefendCompose = _loc6_.readInt();
            _loc8_.AgilityCompose = _loc6_.readInt();
            _loc8_.LuckCompose = _loc6_.readInt();
            _loc8_.IsBinds = _loc6_.readBoolean();
            _loc8_.Quality = _loc6_.readInt();
            _loc7_.push(_loc8_);
            _loc9_++;
         }
         var _loc5_:Vector.<InventoryItemInfo> = _loc7_.slice();
         var _loc2_:int = _loc5_.length;
         while(_loc2_)
         {
            _loc2_--;
            _loc5_.push(_loc5_.splice(int(Math.random() * _loc2_),1)[0]);
         }
         _model.goods = _loc5_;
         dispatchEvent(new Event("allgoodsinfo"));
      }
      
      private function __onTurnGoodsInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         _model.coins = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         iteminfo = new InventoryItemInfo();
         iteminfo = getTemplateInfo(_loc2_);
         iteminfo.StrengthenLevel = _loc3_.readInt();
         iteminfo.Count = _loc3_.readInt();
         iteminfo.ValidDate = _loc3_.readInt();
         iteminfo.AttackCompose = _loc3_.readInt();
         iteminfo.DefendCompose = _loc3_.readInt();
         iteminfo.AgilityCompose = _loc3_.readInt();
         iteminfo.LuckCompose = _loc3_.readInt();
         iteminfo.IsBinds = _loc3_.readBoolean();
         dispatchEvent(new Event("turngoodsinfo"));
      }
      
      private function __onUpdateReward(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.readInt();
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:String = _loc4_.readUTF();
         rewardMsg = {};
         rewardMsg.goodsID = _loc5_;
         rewardMsg.count = _loc2_;
         rewardMsg.name = _loc3_;
         dispatchEvent(new Event("updatereward"));
      }
      
      private function __onReward(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc5_:Vector.<Array> = new Vector.<Array>();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = [];
            _loc3_.push(_loc4_.readInt());
            _loc3_.push(_loc4_.readInt());
            _loc3_.push(_loc4_.readUTF());
            _loc5_.push(_loc3_);
            _loc6_++;
         }
         _model.newRewardList = _loc5_;
      }
      
      private function __onAwardRank(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:int = _loc4_.readInt();
         var _loc5_:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc2_ = _loc4_.readInt();
            _loc6_ = getTemplateInfo(_loc2_);
            _loc6_.StrengthenLevel = _loc4_.readInt();
            _loc6_.Count = _loc4_.readInt();
            _loc6_.ValidDate = _loc4_.readInt();
            _loc6_.AttackCompose = _loc4_.readInt();
            _loc6_.DefendCompose = _loc4_.readInt();
            _loc6_.AgilityCompose = _loc4_.readInt();
            _loc6_.LuckCompose = _loc4_.readInt();
            _loc6_.IsBinds = _loc4_.readBoolean();
            _loc6_.Quality = _loc4_.readInt();
            _loc5_.push(_loc6_);
            _loc7_++;
         }
         _model.reward = _loc5_;
      }
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         ItemManager.fill(_loc2_);
         return _loc2_;
      }
      
      public function addEnterIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            HallIconManager.instance.updateSwitchHandler("luckStar",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("luckStar",true,10);
         }
      }
      
      public function onClickLuckyStarIocn(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(StateManager.currentStateType == "main")
         {
            dispatchEvent(new Event("loaderluckstaricon"));
         }
      }
      
      public function disposeEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("luckStar",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("luckStar",false);
      }
      
      public function dispose() : void
      {
         disposeEnterIcon();
      }
      
      public function openLuckyStarFrame() : void
      {
         dispatchEvent(new Event("openluckystarframe"));
         addSocketEvent();
         SocketManager.Instance.out.sendLuckyStarEnter();
      }
      
      public function addSocketEvent() : void
      {
         SocketManager.Instance.addEventListener("luckystargoodsinfo",__onTurnGoodsInfo);
         SocketManager.Instance.addEventListener("luckystarrewardinfo",__onUpdateReward);
         SocketManager.Instance.addEventListener("luckystarallgoods",__onAllGoodsInfo);
         SocketManager.Instance.addEventListener("luckystarrecord",__onReward);
         SocketManager.Instance.addEventListener("luckystarawardrank",__onAwardRank);
      }
      
      public function removeSocketEvent() : void
      {
         SocketManager.Instance.removeEventListener("luckystargoodsinfo",__onTurnGoodsInfo);
         SocketManager.Instance.removeEventListener("luckystarrewardinfo",__onUpdateReward);
         SocketManager.Instance.removeEventListener("luckystarallgoods",__onAllGoodsInfo);
         SocketManager.Instance.removeEventListener("luckystarrecord",__onReward);
         SocketManager.Instance.removeEventListener("luckystarawardrank",__onAwardRank);
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get model() : LuckStarModel
      {
         return _model;
      }
   }
}
