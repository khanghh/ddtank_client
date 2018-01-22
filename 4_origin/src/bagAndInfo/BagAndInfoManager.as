package bagAndInfo
{
   import bagAndInfo.bag.ring.data.RingDataAnalyzer;
   import bagAndInfo.bag.ring.data.RingSystemData;
   import bagAndInfo.bag.trailelite.data.TrailEliteModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.view.bossbox.AwardsView;
   import explorerManual.ExplorerManualManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import game.GameManager;
   import road7th.comm.PackageIn;
   
   public class BagAndInfoManager extends EventDispatcher
   {
      
      private static var _instance:BagAndInfoManager;
       
      
      public var RingData:Dictionary;
      
      public var isInBagAndInfoView:Boolean;
      
      public var isUpgradePack:Boolean;
      
      private var _observerDictionary:Dictionary;
      
      public var trialEliteModel:TrailEliteModel;
      
      private var _bagAndGiftFrame:BagAndGiftFrame;
      
      private var _frame:BaseAlerFrame;
      
      private var _type:int = 0;
      
      private var infos:Array;
      
      private var name:String;
      
      private var bagtype:int = 0;
      
      public function BagAndInfoManager(param1:SingletonForce)
      {
         super();
         _observerDictionary = new Dictionary();
         trialEliteModel = new TrailEliteModel();
      }
      
      public static function get Instance() : BagAndInfoManager
      {
         if(_instance == null)
         {
            _instance = new BagAndInfoManager(new SingletonForce());
         }
         return _instance;
      }
      
      public function get isShown() : Boolean
      {
         if(!_bagAndGiftFrame)
         {
            return false;
         }
         return true;
      }
      
      public function getBagAndGiftFrame() : BagAndGiftFrame
      {
         return _bagAndGiftFrame;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(63),__openPreviewListFrame);
         SocketManager.Instance.addEventListener("trailElite",_trailEliteHanlder);
      }
      
      public function registerOnPreviewFrameCloseHandler(param1:String, param2:Function) : void
      {
         if(_observerDictionary[param1] != null)
         {
            return;
         }
         _observerDictionary[param1] = param2;
      }
      
      public function unregisterOnPreviewFrameCloseHandler(param1:String) : void
      {
         if(_observerDictionary[param1] != null)
         {
            delete _observerDictionary[param1];
         }
      }
      
      private function _trailEliteHanlder(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         switch(int(_loc2_) - 1)
         {
            case 0:
            case 1:
               trialEliteModel.isOpen = _loc3_.readBoolean();
               trialEliteModel.battleRank = _loc3_.readInt();
               PlayerManager.Instance.Self.trailEliteLevel = trialEliteModel.battleRank;
               trialEliteModel.battleScore = _loc3_.readInt();
               trialEliteModel.totalCount = _loc3_.readInt();
               trialEliteModel.totalWin = _loc3_.readInt();
               trialEliteModel.rankUpCount = _loc3_.readInt();
               trialEliteModel.rankUpWin = _loc3_.readInt();
               trialEliteModel.isRankUp = _loc3_.readInt();
               trialEliteModel.lastDays = _loc3_.readInt();
               break;
            case 2:
               trialEliteModel.isOpen = _loc3_.readBoolean();
               trialEliteModel.lastDays = _loc3_.readInt();
         }
      }
      
      protected function __openPreviewListFrame(param1:PkgEvent) : void
      {
         var _loc11_:int = 0;
         var _loc10_:* = null;
         var _loc4_:int = 0;
         var _loc8_:PackageIn = param1.pkg;
         _loc8_.position = 20;
         var _loc2_:String = _loc8_.readUTF();
         var _loc5_:int = _loc8_.readInt();
         infos = [];
         _loc11_ = 0;
         while(_loc11_ < _loc5_)
         {
            _loc10_ = new InventoryItemInfo();
            _loc10_.TemplateID = _loc8_.readInt();
            _loc10_ = ItemManager.fill(_loc10_);
            _loc10_.Count = _loc8_.readInt();
            _loc10_.IsBinds = _loc8_.readBoolean();
            _loc10_.ValidDate = _loc8_.readInt();
            _loc10_.StrengthenLevel = _loc8_.readInt();
            _loc10_.AttackCompose = _loc8_.readInt();
            _loc10_.DefendCompose = _loc8_.readInt();
            _loc10_.AgilityCompose = _loc8_.readInt();
            _loc10_.LuckCompose = _loc8_.readInt();
            if(EquipType.isMagicStone(_loc10_.CategoryID))
            {
               _loc10_.Level = _loc10_.StrengthenLevel;
               _loc10_.Attack = _loc10_.AttackCompose;
               _loc10_.Defence = _loc10_.DefendCompose;
               _loc10_.Agility = _loc10_.AgilityCompose;
               _loc10_.Luck = _loc10_.LuckCompose;
               _loc10_.Level = _loc10_.StrengthenLevel;
               _loc10_.MagicAttack = _loc8_.readInt();
               _loc10_.MagicDefence = _loc8_.readInt();
            }
            else
            {
               _loc8_.readInt();
               _loc8_.readInt();
            }
            _loc10_.Hole1 = _loc8_.readInt();
            _loc10_.ItemID = _loc8_.readInt();
            infos.push(_loc10_);
            _loc11_++;
         }
         var _loc6_:int = _loc8_.readInt();
         var _loc9_:int = _loc8_.readInt();
         var _loc7_:int = _loc8_.readInt();
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc3_.push(_loc8_.readInt());
            _loc4_++;
         }
         if(_loc3_.length > 0)
         {
            ExplorerManualManager.instance.cachNewChapter = _loc3_;
         }
         if(_loc9_ == 72 || _loc9_ == 71)
         {
            explorerManualPrompt(_loc6_,_loc2_);
         }
         else
         {
            infos = mergeInfos(infos);
            showPreviewFrame(_loc2_,infos);
         }
      }
      
      private function explorerManualPrompt(param1:int, param2:String) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("explorerManual.manualOpen.goodPrompt",param1,param2);
         MessageTipManager.getInstance().show(_loc3_,0,true);
      }
      
      private function mergeInfos(param1:Array) : Array
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc3_:Dictionary = new Dictionary();
         var _loc5_:Array = [];
         var _loc7_:int = infos.length;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_ = infos[_loc8_];
            if(_loc6_.CategoryID == 69)
            {
               _loc5_.push(_loc6_);
            }
            else if(_loc3_[_loc6_.TemplateID] == null)
            {
               _loc3_[_loc6_.TemplateID] = infos[_loc8_];
            }
            else
            {
               _loc3_[_loc6_.TemplateID].Count = _loc3_[_loc6_.TemplateID].Count + infos[_loc8_].Count;
            }
            _loc8_++;
         }
         param1.length = 0;
         param1 = null;
         var _loc4_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            _loc4_.push(_loc2_);
         }
         return _loc4_.concat(_loc5_);
      }
      
      public function showPreviewFrame(param1:String, param2:Array) : BaseAlerFrame
      {
         var _loc5_:AwardsView = new AwardsView();
         _loc5_.goodsList = param2;
         _loc5_.boxType = 4;
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creat("wtm.awardsFFT");
         if(isUpgradePack)
         {
            isUpgradePack = false;
            _loc4_.text = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle2");
            _loc4_.x = 30;
         }
         else
         {
            _loc4_.text = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle");
            _loc4_.x = 81;
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename("wtm.ItemPreviewListFrame");
         var _loc3_:AlertInfo = new AlertInfo(param1);
         _loc3_.showCancel = false;
         _loc3_.moveEnable = false;
         _frame.info = _loc3_;
         _frame.addToContent(_loc5_);
         _frame.addToContent(_loc4_);
         _frame.addEventListener("response",__frameClose);
         LayerManager.Instance.addToLayer(_frame,3,true,1);
         return _frame;
      }
      
      private function __frameClose(param1:FrameEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _loc4_ = param1.currentTarget as BaseAlerFrame;
               _loc4_.removeEventListener("response",__frameClose);
               _loc2_ = infos;
               _loc4_.dispose();
               SocketManager.Instance.out.sendClearStoreBag();
               var _loc6_:int = 0;
               var _loc5_:* = _observerDictionary;
               for each(var _loc3_ in _observerDictionary)
               {
                  _loc3_(_loc2_);
               }
               infos = null;
         }
      }
      
      public function showBagAndInfo(param1:int = 0, param2:String = "", param3:int = 0) : void
      {
         _type = param1;
         this.name = param2;
         this.bagtype = param3;
         if(_bagAndGiftFrame)
         {
            _bagAndGiftFrame.show(param1);
            dispatchEvent(new Event("open"));
         }
         else
         {
            loadModule();
         }
      }
      
      private function loadModule() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatTexpExpLoader());
         AssetModuleLoader.addModelLoader("ddtbagandinfo",6);
         AssetModuleLoader.addModelLoader("ddtbead",6);
         AssetModuleLoader.addModelLoader("gemstone",6);
         AssetModuleLoader.addModelLoader("ddtstore",6);
         AssetModuleLoader.startCodeLoader(createBagAndGiftFrame);
      }
      
      private function createBagAndGiftFrame() : void
      {
         _bagAndGiftFrame = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame");
         if(GameManager.exploreOver)
         {
            _bagAndGiftFrame.show(8,name,bagtype);
         }
         else
         {
            _bagAndGiftFrame.show(_type,name,bagtype);
         }
         dispatchEvent(new Event("open"));
      }
      
      public function hideBagAndInfo() : void
      {
         if(_bagAndGiftFrame)
         {
            _bagAndGiftFrame.dispose();
            _bagAndGiftFrame = null;
            dispatchEvent(new Event("close"));
         }
      }
      
      public function clearReference() : void
      {
         _bagAndGiftFrame = null;
         dispatchEvent(new Event("close"));
      }
      
      public function loadRingSystemInfo(param1:RingDataAnalyzer) : void
      {
         RingData = param1.data;
      }
      
      public function getCurrentRingData() : RingSystemData
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:int = PlayerManager.Instance.Self.RingExp;
         _loc3_ = 1;
         while(_loc3_ <= RingSystemData.TotalLevel)
         {
            if(_loc1_ <= 0)
            {
               _loc2_ = RingData[1];
               break;
            }
            if(_loc1_ < RingData[_loc3_].Exp)
            {
               _loc2_ = RingData[_loc3_ - 1];
               break;
            }
            if(_loc3_ == RingSystemData.TotalLevel && _loc1_ >= RingData[_loc3_].Exp)
            {
               _loc2_ = RingData[_loc3_];
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getRingData(param1:int) : RingSystemData
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = param1;
         _loc4_ = 1;
         while(_loc4_ <= RingSystemData.TotalLevel)
         {
            if(_loc2_ <= 0)
            {
               _loc3_ = RingData[1];
               break;
            }
            if(_loc2_ < RingData[_loc4_].Exp)
            {
               _loc3_ = RingData[_loc4_ - 1];
               break;
            }
            if(_loc4_ == RingSystemData.TotalLevel && _loc2_ >= RingData[_loc4_].Exp)
            {
               _loc3_ = RingData[_loc4_];
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

class SingletonForce
{
    
   
   function SingletonForce()
   {
      super();
   }
}

class _DataOnClickOKButton
{
    
   
   public var id:String;
   
   public var func:Function;
   
   function _DataOnClickOKButton(param1:String, param2:Function)
   {
      super();
      id = param1;
      func = param2;
   }
}
