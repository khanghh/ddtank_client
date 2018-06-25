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
      
      public function BagAndInfoManager(sinle:SingletonForce)
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
      
      public function registerOnPreviewFrameCloseHandler($id:String, $func:Function) : void
      {
         if(_observerDictionary[$id] != null)
         {
            return;
         }
         _observerDictionary[$id] = $func;
      }
      
      public function unregisterOnPreviewFrameCloseHandler($id:String) : void
      {
         if(_observerDictionary[$id] != null)
         {
            delete _observerDictionary[$id];
         }
      }
      
      private function _trailEliteHanlder(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = pkg.readInt();
         switch(int(cmd) - 1)
         {
            case 0:
            case 1:
               trialEliteModel.isOpen = pkg.readBoolean();
               trialEliteModel.battleRank = pkg.readInt();
               PlayerManager.Instance.Self.trailEliteLevel = trialEliteModel.battleRank;
               trialEliteModel.battleScore = pkg.readInt();
               trialEliteModel.totalCount = pkg.readInt();
               trialEliteModel.totalWin = pkg.readInt();
               trialEliteModel.rankUpCount = pkg.readInt();
               trialEliteModel.rankUpWin = pkg.readInt();
               trialEliteModel.isRankUp = pkg.readInt();
               trialEliteModel.lastDays = pkg.readInt();
               break;
            case 2:
               trialEliteModel.isOpen = pkg.readBoolean();
               trialEliteModel.lastDays = pkg.readInt();
         }
      }
      
      protected function __openPreviewListFrame(evt:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var count:int = 0;
         var pkg:PackageIn = evt.pkg;
         pkg.position = 20;
         var itemName:String = pkg.readUTF();
         var cnt:int = pkg.readInt();
         infos = [];
         for(i = 0; i < cnt; )
         {
            info = new InventoryItemInfo();
            info.TemplateID = pkg.readInt();
            info = ItemManager.fill(info);
            info.Count = pkg.readInt();
            info.IsBinds = pkg.readBoolean();
            info.ValidDate = pkg.readInt();
            info.StrengthenLevel = pkg.readInt();
            info.AttackCompose = pkg.readInt();
            info.DefendCompose = pkg.readInt();
            info.AgilityCompose = pkg.readInt();
            info.LuckCompose = pkg.readInt();
            if(EquipType.isMagicStone(info.CategoryID))
            {
               info.Level = info.StrengthenLevel;
               info.Attack = info.AttackCompose;
               info.Defence = info.DefendCompose;
               info.Agility = info.AgilityCompose;
               info.Luck = info.LuckCompose;
               info.Level = info.StrengthenLevel;
               info.MagicAttack = pkg.readInt();
               info.MagicDefence = pkg.readInt();
            }
            else
            {
               pkg.readInt();
               pkg.readInt();
            }
            info.Hole1 = pkg.readInt();
            info.ItemID = pkg.readInt();
            infos.push(info);
            i++;
         }
         var openCount:int = pkg.readInt();
         var openType:int = pkg.readInt();
         var belongChapterCount:int = pkg.readInt();
         var chapterArr:Array = [];
         for(count = 0; count < belongChapterCount; )
         {
            chapterArr.push(pkg.readInt());
            count++;
         }
         if(chapterArr.length > 0)
         {
            ExplorerManualManager.instance.cachNewChapter = chapterArr;
         }
         if(openType == 72 || openType == 71)
         {
            explorerManualPrompt(openCount,itemName);
         }
         else
         {
            infos = mergeInfos(infos);
            showPreviewFrame(itemName,infos);
         }
      }
      
      private function explorerManualPrompt(count:int, name:String) : void
      {
         var str:String = LanguageMgr.GetTranslation("explorerManual.manualOpen.goodPrompt",count,name);
         MessageTipManager.getInstance().show(str,0,true);
      }
      
      private function mergeInfos($infos:Array) : Array
      {
         var i:int = 0;
         var value:* = null;
         var infoDic:Dictionary = new Dictionary();
         var extra:Array = [];
         var len:int = infos.length;
         for(i = 0; i < len; )
         {
            value = infos[i];
            if(value.CategoryID == 69)
            {
               extra.push(value);
            }
            else if(infoDic[value.TemplateID] == null)
            {
               infoDic[value.TemplateID] = infos[i];
            }
            else
            {
               infoDic[value.TemplateID].Count = infoDic[value.TemplateID].Count + infos[i].Count;
            }
            i++;
         }
         $infos.length = 0;
         $infos = null;
         var newInfos:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = infoDic;
         for each(var v in infoDic)
         {
            newInfos.push(v);
         }
         return newInfos.concat(extra);
      }
      
      public function showPreviewFrame(itemName:String, infos:Array) : BaseAlerFrame
      {
         var aView:AwardsView = new AwardsView();
         aView.goodsList = infos;
         aView.boxType = 4;
         var title:FilterFrameText = ComponentFactory.Instance.creat("wtm.awardsFFT");
         if(isUpgradePack)
         {
            isUpgradePack = false;
            title.text = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle2");
            title.x = 30;
         }
         else
         {
            title.text = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle");
            title.x = 81;
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename("wtm.ItemPreviewListFrame");
         var ai:AlertInfo = new AlertInfo(itemName);
         ai.showCancel = false;
         ai.moveEnable = false;
         _frame.info = ai;
         _frame.addToContent(aView);
         _frame.addToContent(title);
         _frame.addEventListener("response",__frameClose);
         LayerManager.Instance.addToLayer(_frame,3,true,1);
         return _frame;
      }
      
      private function __frameClose(event:FrameEvent) : void
      {
         var bAFrame:* = null;
         var itemList:* = null;
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               bAFrame = event.currentTarget as BaseAlerFrame;
               bAFrame.removeEventListener("response",__frameClose);
               itemList = infos;
               bAFrame.dispose();
               SocketManager.Instance.out.sendClearStoreBag();
               var _loc6_:int = 0;
               var _loc5_:* = _observerDictionary;
               for each(var func in _observerDictionary)
               {
                  func(itemList);
               }
               infos = null;
         }
      }
      
      public function showBagAndInfo(type:int = 0, name:String = "", bagtype:int = 0) : void
      {
         _type = type;
         this.name = name;
         this.bagtype = bagtype;
         if(_bagAndGiftFrame)
         {
            _bagAndGiftFrame.show(type);
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
      
      public function loadRingSystemInfo(data:RingDataAnalyzer) : void
      {
         RingData = data.data;
      }
      
      public function getCurrentRingData() : RingSystemData
      {
         var data:* = null;
         var i:int = 0;
         var selfExp:int = PlayerManager.Instance.Self.RingExp;
         for(i = 1; i <= RingSystemData.TotalLevel; )
         {
            if(selfExp <= 0)
            {
               data = RingData[1];
               break;
            }
            if(selfExp < RingData[i].Exp)
            {
               data = RingData[i - 1];
               break;
            }
            if(i == RingSystemData.TotalLevel && selfExp >= RingData[i].Exp)
            {
               data = RingData[i];
            }
            i++;
         }
         return data;
      }
      
      public function getRingData(RingExp:int) : RingSystemData
      {
         var data:* = null;
         var i:int = 0;
         var playerExp:* = RingExp;
         for(i = 1; i <= RingSystemData.TotalLevel; )
         {
            if(playerExp <= 0)
            {
               data = RingData[1];
               break;
            }
            if(playerExp < RingData[i].Exp)
            {
               data = RingData[i - 1];
               break;
            }
            if(i == RingSystemData.TotalLevel && playerExp >= RingData[i].Exp)
            {
               data = RingData[i];
            }
            i++;
         }
         return data;
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
   
   function _DataOnClickOKButton($id:String, $func:Function)
   {
      super();
      id = $id;
      func = $func;
   }
}
