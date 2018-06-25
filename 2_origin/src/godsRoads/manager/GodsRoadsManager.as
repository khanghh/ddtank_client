package godsRoads.manager
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import godsRoads.analyze.GodsRoadsDataAnalyzer;
   import godsRoads.data.GodsRoadsMissionVo;
   import godsRoads.data.GodsRoadsStepVo;
   import godsRoads.data.GodsRoadsVo;
   import godsRoads.model.GodsRoadsModel;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GodsRoadsManager extends EventDispatcher
   {
      
      private static var _instance:GodsRoadsManager;
      
      public static const GODSROADS_CHANGESTEPS:String = "godsroadschangesteps";
      
      public static const GODSROADS_OPENFRAME:String = "godsroadsopenframe";
      
      public static const GODSROADS_DISPOSE:String = "godsroadsdispose";
       
      
      public var _model:GodsRoadsModel;
      
      private var _isOpen:Boolean = false;
      
      private var _func:Function;
      
      private var _xml:XML;
      
      private var _funcParams:Array;
      
      public var level:int;
      
      public function GodsRoadsManager(privateClass:PrivateClass)
      {
         _funcParams = [];
         super();
         _model = new GodsRoadsModel();
      }
      
      public static function get instance() : GodsRoadsManager
      {
         if(GodsRoadsManager._instance == null)
         {
            GodsRoadsManager._instance = new GodsRoadsManager(new PrivateClass());
         }
         return GodsRoadsManager._instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("gods_roads",pkgHandler);
      }
      
      public function loadGodsRoadsModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("godsroads");
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "godsroads")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            if(null != _func)
            {
               _func.apply(null,_funcParams);
            }
            _func = null;
            _funcParams = null;
         }
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "godsroads")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function pkgHandler(e:CrazyTankSocketEvent) : void
      {
         var flag:Boolean = false;
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         switch(int(cmd) - 86)
         {
            case 0:
               _isOpen = pkg.readBoolean();
               if(_isOpen)
               {
                  showGodsRoads();
               }
               else
               {
                  hideGodsRoadsIcon();
               }
               break;
            case 1:
               doOpenGodsRoads(pkg);
               break;
            case 2:
               flag = pkg.readBoolean();
               if(flag)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.godsRoads.getawards"));
               }
               sendEnter();
         }
      }
      
      public function changeSteps(lv:int) : void
      {
         level = lv;
         dispatchEvent(new Event("godsroadschangesteps"));
      }
      
      public function templateDataSetup(analyzer:DataAnalyzer) : void
      {
         if(analyzer is GodsRoadsDataAnalyzer)
         {
            _model.missionInfo = GodsRoadsDataAnalyzer(analyzer).dataList;
         }
         dispatchEvent(new Event("XMLdata_Complete"));
      }
      
      public function showGodsRoads() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            HallIconManager.instance.updateSwitchHandler("godsRoads",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("godsRoads",true,10);
         }
      }
      
      private function hideGodsRoadsIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("godsRoads",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("godsRoads",false);
      }
      
      public function openGodsRoads(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Grade < 10)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
            return;
         }
         loadGodsRoadsModule(sendEnter);
      }
      
      private function sendEnter() : void
      {
         SocketManager.Instance.out.enterGodsRoads();
      }
      
      private function doOpenGodsRoads(pkg:PackageIn) : void
      {
         var i:int = 0;
         var sVo:* = null;
         var ii:int = 0;
         var mVo:* = null;
         var j:int = 0;
         var id:int = 0;
         var item:* = null;
         var aVo:* = null;
         var k:int = 0;
         var idd:int = 0;
         var itemm:* = null;
         var aaVo:* = null;
         _model.godsRoadsData = new GodsRoadsVo();
         var vo:GodsRoadsVo = _model.godsRoadsData;
         vo.Level = pkg.readInt();
         vo.currentLevel = pkg.readInt();
         vo.steps = new Vector.<GodsRoadsStepVo>();
         for(i = 0; i < vo.Level; )
         {
            sVo = new GodsRoadsStepVo();
            sVo.isGetAwards = pkg.readBoolean();
            sVo.missionsNum = pkg.readInt();
            sVo.currentStep = i + 1;
            sVo.awards = [];
            sVo.missionVos = [];
            for(ii = 0; ii < sVo.missionsNum; )
            {
               mVo = new GodsRoadsMissionVo();
               mVo.ID = pkg.readInt();
               mVo.isFinished = pkg.readBoolean();
               mVo.condition1 = pkg.readInt();
               mVo.condition2 = pkg.readInt();
               mVo.condition3 = pkg.readInt();
               mVo.condition4 = pkg.readInt();
               mVo.isGetAwards = pkg.readBoolean();
               mVo.awardsNum = pkg.readInt();
               mVo.awards = [];
               for(j = 0; j < mVo.awardsNum; )
               {
                  id = pkg.readInt();
                  item = ItemManager.Instance.getTemplateById(id);
                  aVo = new InventoryItemInfo();
                  ObjectUtils.copyProperties(aVo,item);
                  aVo.TemplateID = id;
                  aVo.StrengthenLevel = pkg.readInt();
                  aVo.Count = pkg.readInt();
                  aVo.ValidDate = pkg.readInt();
                  aVo.AttackCompose = pkg.readInt();
                  aVo.DefendCompose = pkg.readInt();
                  aVo.AgilityCompose = pkg.readInt();
                  aVo.LuckCompose = pkg.readInt();
                  aVo.IsBinds = pkg.readBoolean();
                  mVo.awards.push(aVo);
                  j++;
               }
               sVo.missionVos.push(mVo);
               ii++;
            }
            vo.steps.push(sVo);
            sVo.awadsNum = pkg.readInt();
            for(k = 0; k < sVo.awadsNum; )
            {
               idd = pkg.readInt();
               itemm = ItemManager.Instance.getTemplateById(idd);
               aaVo = new InventoryItemInfo();
               ObjectUtils.copyProperties(aaVo,itemm);
               aaVo.TemplateID = idd;
               aaVo.StrengthenLevel = pkg.readInt();
               aaVo.Count = pkg.readInt();
               aaVo.ValidDate = pkg.readInt();
               aaVo.AttackCompose = pkg.readInt();
               aaVo.DefendCompose = pkg.readInt();
               aaVo.AgilityCompose = pkg.readInt();
               aaVo.LuckCompose = pkg.readInt();
               aaVo.IsBinds = pkg.readBoolean();
               sVo.awards.push(aaVo);
               k++;
            }
            i++;
         }
         dispatchEvent(new Event("godsroadsopenframe"));
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get XMLData() : XML
      {
         return _xml;
      }
      
      public function set XMLData(val:XML) : void
      {
         _xml = val;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
