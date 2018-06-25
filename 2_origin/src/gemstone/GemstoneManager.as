package gemstone
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.EventDispatcher;
   import gemstone.info.GemstListInfo;
   import gemstone.info.GemstonInitInfo;
   import gemstone.info.GemstoneAnalyze;
   import gemstone.info.GemstoneInfo;
   import gemstone.info.GemstoneStaticInfo;
   import gemstone.info.GemstoneUpGradeInfo;
   import gemstone.items.ExpBar;
   import gemstone.items.GemstoneContent;
   import gemstone.items.Item;
   
   public class GemstoneManager extends EventDispatcher
   {
      
      public static const GOLDEN_LEVEL:int = 6;
      
      private static var _instance:GemstoneManager;
      
      public static const SuitPLACE:int = 11;
      
      public static const GlassPPLACE:int = 5;
      
      public static const HariPPLACE:int = 2;
      
      public static const FacePLACE:int = 3;
      
      public static const DecorationPLACE:int = 13;
      
      public static const ID1:int = 100001;
      
      public static const ID2:int = 100002;
      
      public static const ID3:int = 100003;
      
      public static const ID4:int = 100004;
      
      public static const ID5:int = 100005;
       
      
      private var _gemstoneFrame:GemstoneFrame;
      
      private var _stoneInfoList:Vector.<GemstoneInfo>;
      
      private var _stoneItemList:Vector.<Item>;
      
      private var _stoneContentGroupList:Array;
      
      private var _stoneContentList:Array;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _loader:BaseLoader;
      
      private var _redUrl:String;
      
      private var _bulUrl:String;
      
      private var _greUrl:String;
      
      private var _yelUrl:String;
      
      private var _purpleUrl:String;
      
      private var _upGradeList:Vector.<GemstoneUpGradeInfo>;
      
      public var redInfoList:Vector.<GemstoneStaticInfo>;
      
      public var bluInfoList:Vector.<GemstoneStaticInfo>;
      
      public var greInfoList:Vector.<GemstoneStaticInfo>;
      
      public var yelInfoList:Vector.<GemstoneStaticInfo>;
      
      public var purpleInfoList:Vector.<GemstoneStaticInfo>;
      
      public var curstatiDataList:Vector.<GemstoneStaticInfo>;
      
      public var curItem:GemstoneContent;
      
      public var curGemstoneUpInfo:GemstoneUpGradeInfo;
      
      private var _gInfoList:Object;
      
      public var curUpInfoList:Vector.<GemstListInfo>;
      
      public var suitList:Vector.<GemstListInfo>;
      
      public var glassList:Vector.<GemstListInfo>;
      
      public var hariList:Vector.<GemstListInfo>;
      
      public var faceList:Vector.<GemstListInfo>;
      
      public var decorationList:Vector.<GemstListInfo>;
      
      public var curMaxLevel:uint;
      
      public function GemstoneManager()
      {
         suitList = new Vector.<GemstListInfo>();
         glassList = new Vector.<GemstListInfo>();
         hariList = new Vector.<GemstListInfo>();
         faceList = new Vector.<GemstListInfo>();
         decorationList = new Vector.<GemstListInfo>();
         super();
         _upGradeList = new Vector.<GemstoneUpGradeInfo>();
      }
      
      public static function get Instance() : GemstoneManager
      {
         if(_instance == null)
         {
            _instance = new GemstoneManager();
         }
         return _instance;
      }
      
      public function loaderData() : void
      {
         _loader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("FightSpiritTemplateList.xml"),5);
         _loader.addEventListener("complete",loaderComplete);
      }
      
      private function compeleteHander(analyze:GemstoneAnalyze) : void
      {
      }
      
      private function loaderComplete(event:LoaderEvent) : void
      {
         var i:int = 0;
         var gInfo:* = null;
         redInfoList = new Vector.<GemstoneStaticInfo>();
         bluInfoList = new Vector.<GemstoneStaticInfo>();
         greInfoList = new Vector.<GemstoneStaticInfo>();
         yelInfoList = new Vector.<GemstoneStaticInfo>();
         purpleInfoList = new Vector.<GemstoneStaticInfo>();
         _gInfoList = new Vector.<GemstoneStaticInfo>();
         var xml:XML = new XML(event.loader.content);
         var len:int = xml.item.length();
         for(i = 0; i < len; )
         {
            gInfo = new GemstoneStaticInfo();
            gInfo.id = xml.item[i].@FightSpiritID;
            gInfo.fightSpiritIcon = xml.item[i].@FightSpiritIcon;
            gInfo.attack = xml.item[i].@Attack;
            gInfo.level = xml.item[i].@Level;
            gInfo.luck = xml.item[i].@Lucky;
            gInfo.Exp = xml.item[i].@Exp;
            gInfo.agility = xml.item[i].@Agility;
            gInfo.defence = xml.item[i].@Defence;
            gInfo.blood = xml.item[i].@Blood;
            _gInfoList.push(gInfo);
            if(gInfo.id == 100001)
            {
               GemstoneManager.Instance.setRedUrl(gInfo.fightSpiritIcon);
               redInfoList.push(gInfo);
            }
            else if(gInfo.id == 100002)
            {
               GemstoneManager.Instance.setBulUrl(gInfo.fightSpiritIcon);
               bluInfoList.push(gInfo);
            }
            else if(gInfo.id == 100003)
            {
               GemstoneManager.Instance.setGreUrl(gInfo.fightSpiritIcon);
               greInfoList.push(gInfo);
            }
            else if(gInfo.id == 100004)
            {
               GemstoneManager.Instance.setYelUrl(gInfo.fightSpiritIcon);
               yelInfoList.push(gInfo);
            }
            else if(gInfo.id == 100005)
            {
               GemstoneManager.Instance.setPurpleUrl(gInfo.fightSpiritIcon);
               purpleInfoList.push(gInfo);
            }
            i++;
         }
         curMaxLevel = bluInfoList.length - 1;
      }
      
      public function initView() : GemstoneFrame
      {
         _gemstoneFrame = ComponentFactory.Instance.creatCustomObject("gemstoneFrame");
         return _gemstoneFrame;
      }
      
      public function initFrame(gemstoneFrame:GemstoneFrame) : void
      {
         _gemstoneFrame = gemstoneFrame;
      }
      
      public function clearFrame() : void
      {
         _gemstoneFrame = null;
      }
      
      public function upDataFitCount() : void
      {
         if(_gemstoneFrame)
         {
            _gemstoneFrame.upDatafitCount();
         }
      }
      
      public function get gemstoneFrame() : GemstoneFrame
      {
         return _gemstoneFrame;
      }
      
      public function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(209,2),playerFigSpiritUp);
         SocketManager.Instance.addEventListener(PkgEvent.format(209,1),playerFigSpiritinit);
      }
      
      private function playerFigSpiritinit(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         var arr:* = null;
         var list:* = undefined;
         var t_i:int = 0;
         var gems1:* = null;
         var ginfo:* = null;
         var bool:Boolean = event.pkg.readBoolean();
         var count:int = event.pkg.readInt();
         for(i = 0; i < count; )
         {
            obj = new GemstonInitInfo();
            obj.userId = event.pkg.readInt();
            obj.figSpiritId = event.pkg.readInt();
            obj.figSpiritIdValue = event.pkg.readUTF();
            obj.equipPlace = event.pkg.readInt();
            arr = rezArr(obj.figSpiritIdValue);
            list = new Vector.<GemstListInfo>();
            for(t_i = 0; t_i < 3; )
            {
               gems1 = arr[t_i].split(",");
               ginfo = new GemstListInfo();
               ginfo.fightSpiritId = obj.figSpiritId;
               ginfo.level = gems1[0];
               ginfo.exp = gems1[1];
               ginfo.place = gems1[2];
               list.push(ginfo);
               t_i++;
            }
            obj.list = list;
            switch(int(obj.equipPlace) - 2)
            {
               case 0:
                  hariList = list;
                  break;
               case 1:
                  faceList = list;
                  break;
               default:
                  faceList = list;
                  break;
               case 3:
                  glassList = list;
                  break;
               default:
                  glassList = list;
                  break;
               default:
                  glassList = list;
                  break;
               default:
                  glassList = list;
                  break;
               default:
                  glassList = list;
                  break;
               default:
                  glassList = list;
                  break;
               case 9:
                  suitList = list;
                  break;
               default:
                  suitList = list;
                  break;
               case 11:
                  decorationList = list;
            }
            i++;
         }
      }
      
      private function rezArr(str:String) : Array
      {
         var arr:Array = str.split("|");
         return arr;
      }
      
      protected function playerFigSpiritUp(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var gemstListInfo:* = null;
         var curGemstoneUpInfo:GemstoneUpGradeInfo = new GemstoneUpGradeInfo();
         curGemstoneUpInfo.isUp = event.pkg.readBoolean();
         curGemstoneUpInfo.isMaxLevel = event.pkg.readBoolean();
         curGemstoneUpInfo.isFall = event.pkg.readBoolean();
         curGemstoneUpInfo.num = event.pkg.readInt();
         var list:Vector.<GemstListInfo> = new Vector.<GemstListInfo>();
         for(var count:int = event.pkg.readInt(); i < count; )
         {
            gemstListInfo = new GemstListInfo();
            gemstListInfo.fightSpiritId = event.pkg.readInt();
            gemstListInfo.level = event.pkg.readInt();
            gemstListInfo.exp = event.pkg.readInt();
            gemstListInfo.place = event.pkg.readInt();
            list.push(gemstListInfo);
            i++;
         }
         curGemstoneUpInfo.equipPlace = event.pkg.readInt();
         curGemstoneUpInfo.dir = event.pkg.readInt();
         curGemstoneUpInfo.list = list;
         setGemstoneListInfo(curGemstoneUpInfo);
         if(_gemstoneFrame)
         {
            _gemstoneFrame.upDatafitCount();
            _gemstoneFrame.gemstoneAction(curGemstoneUpInfo);
         }
         _gemstoneFrame.updateUpButton();
      }
      
      public function loadGemstoneModule(completeHandler:Function = null, completeParams:Array = null) : void
      {
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",completeHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("gemstone");
      }
      
      public function get expBar() : ExpBar
      {
         return _gemstoneFrame.expBar;
      }
      
      public function getRedUrl() : String
      {
         return _redUrl;
      }
      
      public function getYelUrl() : String
      {
         return _yelUrl;
      }
      
      public function getPurpleUrl() : String
      {
         return _purpleUrl;
      }
      
      public function getBulUrl() : String
      {
         return _bulUrl;
      }
      
      public function getGreUrl() : String
      {
         return _greUrl;
      }
      
      public function setRedUrl(str:String) : void
      {
         _redUrl = str;
      }
      
      public function setYelUrl(str:String) : void
      {
         _yelUrl = str;
      }
      
      public function setBulUrl(str:String) : void
      {
         _bulUrl = str;
      }
      
      public function setGreUrl(str:String) : void
      {
         _greUrl = str;
      }
      
      public function setPurpleUrl(str:String) : void
      {
         _purpleUrl = str;
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "gemstone")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      public function getSelfList(p:int) : Vector.<GemstListInfo>
      {
         if(p == 13)
         {
            return decorationList;
         }
         if(p == 3)
         {
            return faceList;
         }
         if(p == 5)
         {
            return glassList;
         }
         if(p == 2)
         {
            return hariList;
         }
         if(p == 11)
         {
            return suitList;
         }
         return null;
      }
      
      public function getByPlayerInfoList(p:int, playerID:int) : Vector.<GemstListInfo>
      {
         var gemstoneList:* = undefined;
         var playerInfo:PlayerInfo = PlayerManager.Instance.findPlayer(playerID);
         if(playerInfo is SelfInfo)
         {
            return getSelfList(p);
         }
         gemstoneList = playerInfo.gemstoneList;
         if(getPlaceByGemstonInitInfo(p,gemstoneList))
         {
            return getPlaceByGemstonInitInfo(p,gemstoneList).list;
         }
         return null;
      }
      
      public function setGemstoneListInfo(info:GemstoneUpGradeInfo) : void
      {
         if(info.equipPlace == 3)
         {
            faceList = info.list;
         }
         else if(info.equipPlace == 11)
         {
            suitList = info.list;
         }
         else if(info.equipPlace == 5)
         {
            glassList = info.list;
         }
         else if(info.equipPlace == 13)
         {
            decorationList = info.list;
         }
         else if(info.equipPlace == 2)
         {
            hariList = info.list;
         }
      }
      
      public function getPlaceByGemstonInitInfo(p:int, gemstoneList:Vector.<GemstonInitInfo>) : GemstonInitInfo
      {
         var i:int = 0;
         if(!gemstoneList || gemstoneList.length <= 0)
         {
            return null;
         }
         i = 0;
         while(i < gemstoneList.length)
         {
            if(gemstoneList[i].equipPlace == p)
            {
               return gemstoneList[i];
            }
            i++;
         }
         return null;
      }
   }
}
