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
      
      private function __onActivityOpen(e:CrazyTankSocketEvent) : void
      {
         if(!_isOpen)
         {
            SocketManager.Instance.addEventListener("luckystarend",__onActivityEnd);
         }
         _isOpen = true;
         addEnterIcon();
      }
      
      private function __onActivityEnd(e:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.removeEventListener("luckystarend",__onActivityEnd);
         _isOpen = false;
         disposeEnterIcon();
      }
      
      private function __onAllGoodsInfo(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var templateID:int = 0;
         var iteminfo:* = null;
         var pkg:PackageIn = e.pkg;
         _model.coins = pkg.readInt();
         _model.setActivityDate(pkg.readDate(),pkg.readDate());
         _model.minUseNum = pkg.readInt();
         var count:int = pkg.readInt();
         var list:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         for(i = 0; i < count; )
         {
            templateID = pkg.readInt();
            iteminfo = getTemplateInfo(templateID);
            iteminfo.StrengthenLevel = pkg.readInt();
            iteminfo.Count = pkg.readInt();
            iteminfo.ValidDate = pkg.readInt();
            iteminfo.AttackCompose = pkg.readInt();
            iteminfo.DefendCompose = pkg.readInt();
            iteminfo.AgilityCompose = pkg.readInt();
            iteminfo.LuckCompose = pkg.readInt();
            iteminfo.IsBinds = pkg.readBoolean();
            iteminfo.Quality = pkg.readInt();
            list.push(iteminfo);
            i++;
         }
         var arr:Vector.<InventoryItemInfo> = list.slice();
         var index:int = arr.length;
         while(index)
         {
            index--;
            arr.push(arr.splice(int(Math.random() * index),1)[0]);
         }
         _model.goods = arr;
         dispatchEvent(new Event("allgoodsinfo"));
      }
      
      private function __onTurnGoodsInfo(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _model.coins = pkg.readInt();
         var templateID:int = pkg.readInt();
         iteminfo = new InventoryItemInfo();
         iteminfo = getTemplateInfo(templateID);
         iteminfo.StrengthenLevel = pkg.readInt();
         iteminfo.Count = pkg.readInt();
         iteminfo.ValidDate = pkg.readInt();
         iteminfo.AttackCompose = pkg.readInt();
         iteminfo.DefendCompose = pkg.readInt();
         iteminfo.AgilityCompose = pkg.readInt();
         iteminfo.LuckCompose = pkg.readInt();
         iteminfo.IsBinds = pkg.readBoolean();
         dispatchEvent(new Event("turngoodsinfo"));
      }
      
      private function __onUpdateReward(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var goodsID:int = pkg.readInt();
         var count:int = pkg.readInt();
         var name:String = pkg.readUTF();
         rewardMsg = {};
         rewardMsg.goodsID = goodsID;
         rewardMsg.count = count;
         rewardMsg.name = name;
         dispatchEvent(new Event("updatereward"));
      }
      
      private function __onReward(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var arr:* = null;
         var pkg:PackageIn = e.pkg;
         var count:int = pkg.readInt();
         var list:Vector.<Array> = new Vector.<Array>();
         for(i = 0; i < count; )
         {
            arr = [];
            arr.push(pkg.readInt());
            arr.push(pkg.readInt());
            arr.push(pkg.readUTF());
            list.push(arr);
            i++;
         }
         _model.newRewardList = list;
      }
      
      private function __onAwardRank(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var templateID:int = 0;
         var iteminfo:* = null;
         var pkg:PackageIn = e.pkg;
         var count:int = pkg.readInt();
         var list:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         for(i = 0; i < count; )
         {
            templateID = pkg.readInt();
            iteminfo = getTemplateInfo(templateID);
            iteminfo.StrengthenLevel = pkg.readInt();
            iteminfo.Count = pkg.readInt();
            iteminfo.ValidDate = pkg.readInt();
            iteminfo.AttackCompose = pkg.readInt();
            iteminfo.DefendCompose = pkg.readInt();
            iteminfo.AgilityCompose = pkg.readInt();
            iteminfo.LuckCompose = pkg.readInt();
            iteminfo.IsBinds = pkg.readBoolean();
            iteminfo.Quality = pkg.readInt();
            list.push(iteminfo);
            i++;
         }
         _model.reward = list;
      }
      
      private function getTemplateInfo(id:int) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = id;
         ItemManager.fill(itemInfo);
         return itemInfo;
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
      
      public function onClickLuckyStarIocn(e:MouseEvent) : void
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
