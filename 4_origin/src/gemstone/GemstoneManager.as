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
      
      private function compeleteHander(param1:GemstoneAnalyze) : void
      {
      }
      
      private function loaderComplete(param1:LoaderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         redInfoList = new Vector.<GemstoneStaticInfo>();
         bluInfoList = new Vector.<GemstoneStaticInfo>();
         greInfoList = new Vector.<GemstoneStaticInfo>();
         yelInfoList = new Vector.<GemstoneStaticInfo>();
         purpleInfoList = new Vector.<GemstoneStaticInfo>();
         _gInfoList = new Vector.<GemstoneStaticInfo>();
         var _loc2_:XML = new XML(param1.loader.content);
         var _loc3_:int = _loc2_.item.length();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new GemstoneStaticInfo();
            _loc4_.id = _loc2_.item[_loc5_].@FightSpiritID;
            _loc4_.fightSpiritIcon = _loc2_.item[_loc5_].@FightSpiritIcon;
            _loc4_.attack = _loc2_.item[_loc5_].@Attack;
            _loc4_.level = _loc2_.item[_loc5_].@Level;
            _loc4_.luck = _loc2_.item[_loc5_].@Lucky;
            _loc4_.Exp = _loc2_.item[_loc5_].@Exp;
            _loc4_.agility = _loc2_.item[_loc5_].@Agility;
            _loc4_.defence = _loc2_.item[_loc5_].@Defence;
            _loc4_.blood = _loc2_.item[_loc5_].@Blood;
            _gInfoList.push(_loc4_);
            if(_loc4_.id == 100001)
            {
               GemstoneManager.Instance.setRedUrl(_loc4_.fightSpiritIcon);
               redInfoList.push(_loc4_);
            }
            else if(_loc4_.id == 100002)
            {
               GemstoneManager.Instance.setBulUrl(_loc4_.fightSpiritIcon);
               bluInfoList.push(_loc4_);
            }
            else if(_loc4_.id == 100003)
            {
               GemstoneManager.Instance.setGreUrl(_loc4_.fightSpiritIcon);
               greInfoList.push(_loc4_);
            }
            else if(_loc4_.id == 100004)
            {
               GemstoneManager.Instance.setYelUrl(_loc4_.fightSpiritIcon);
               yelInfoList.push(_loc4_);
            }
            else if(_loc4_.id == 100005)
            {
               GemstoneManager.Instance.setPurpleUrl(_loc4_.fightSpiritIcon);
               purpleInfoList.push(_loc4_);
            }
            _loc5_++;
         }
         curMaxLevel = bluInfoList.length - 1;
      }
      
      public function initView() : GemstoneFrame
      {
         _gemstoneFrame = ComponentFactory.Instance.creatCustomObject("gemstoneFrame");
         return _gemstoneFrame;
      }
      
      public function initFrame(param1:GemstoneFrame) : void
      {
         _gemstoneFrame = param1;
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
      
      private function playerFigSpiritinit(param1:CrazyTankSocketEvent) : void
      {
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = undefined;
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc8_:* = null;
         var _loc7_:Boolean = param1.pkg.readBoolean();
         var _loc3_:int = param1.pkg.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc3_)
         {
            _loc6_ = new GemstonInitInfo();
            _loc6_.userId = param1.pkg.readInt();
            _loc6_.figSpiritId = param1.pkg.readInt();
            _loc6_.figSpiritIdValue = param1.pkg.readUTF();
            _loc6_.equipPlace = param1.pkg.readInt();
            _loc4_ = rezArr(_loc6_.figSpiritIdValue);
            _loc5_ = new Vector.<GemstListInfo>();
            _loc9_ = 0;
            while(_loc9_ < 3)
            {
               _loc2_ = _loc4_[_loc9_].split(",");
               _loc8_ = new GemstListInfo();
               _loc8_.fightSpiritId = _loc6_.figSpiritId;
               _loc8_.level = _loc2_[0];
               _loc8_.exp = _loc2_[1];
               _loc8_.place = _loc2_[2];
               _loc5_.push(_loc8_);
               _loc9_++;
            }
            _loc6_.list = _loc5_;
            switch(int(_loc6_.equipPlace) - 2)
            {
               case 0:
                  hariList = _loc5_;
                  break;
               case 1:
                  faceList = _loc5_;
                  break;
               default:
                  faceList = _loc5_;
                  break;
               case 3:
                  glassList = _loc5_;
                  break;
               default:
                  glassList = _loc5_;
                  break;
               default:
                  glassList = _loc5_;
                  break;
               default:
                  glassList = _loc5_;
                  break;
               default:
                  glassList = _loc5_;
                  break;
               default:
                  glassList = _loc5_;
                  break;
               case 9:
                  suitList = _loc5_;
                  break;
               default:
                  suitList = _loc5_;
                  break;
               case 11:
                  decorationList = _loc5_;
            }
            _loc10_++;
         }
      }
      
      private function rezArr(param1:String) : Array
      {
         var _loc2_:Array = param1.split("|");
         return _loc2_;
      }
      
      protected function playerFigSpiritUp(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:GemstoneUpGradeInfo = new GemstoneUpGradeInfo();
         _loc3_.isUp = param1.pkg.readBoolean();
         _loc3_.isMaxLevel = param1.pkg.readBoolean();
         _loc3_.isFall = param1.pkg.readBoolean();
         _loc3_.num = param1.pkg.readInt();
         var _loc5_:Vector.<GemstListInfo> = new Vector.<GemstListInfo>();
         var _loc2_:int = param1.pkg.readInt();
         while(_loc6_ < _loc2_)
         {
            _loc4_ = new GemstListInfo();
            _loc4_.fightSpiritId = param1.pkg.readInt();
            _loc4_.level = param1.pkg.readInt();
            _loc4_.exp = param1.pkg.readInt();
            _loc4_.place = param1.pkg.readInt();
            _loc5_.push(_loc4_);
            _loc6_++;
         }
         _loc3_.equipPlace = param1.pkg.readInt();
         _loc3_.dir = param1.pkg.readInt();
         _loc3_.list = _loc5_;
         setGemstoneListInfo(_loc3_);
         if(_gemstoneFrame)
         {
            _gemstoneFrame.upDatafitCount();
            _gemstoneFrame.gemstoneAction(_loc3_);
         }
         _gemstoneFrame.updateUpButton();
      }
      
      public function loadGemstoneModule(param1:Function = null, param2:Array = null) : void
      {
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",param1);
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
      
      public function setRedUrl(param1:String) : void
      {
         _redUrl = param1;
      }
      
      public function setYelUrl(param1:String) : void
      {
         _yelUrl = param1;
      }
      
      public function setBulUrl(param1:String) : void
      {
         _bulUrl = param1;
      }
      
      public function setGreUrl(param1:String) : void
      {
         _greUrl = param1;
      }
      
      public function setPurpleUrl(param1:String) : void
      {
         _purpleUrl = param1;
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "gemstone")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      public function getSelfList(param1:int) : Vector.<GemstListInfo>
      {
         if(param1 == 13)
         {
            return decorationList;
         }
         if(param1 == 3)
         {
            return faceList;
         }
         if(param1 == 5)
         {
            return glassList;
         }
         if(param1 == 2)
         {
            return hariList;
         }
         if(param1 == 11)
         {
            return suitList;
         }
         return null;
      }
      
      public function getByPlayerInfoList(param1:int, param2:int) : Vector.<GemstListInfo>
      {
         var _loc3_:* = undefined;
         var _loc4_:PlayerInfo = PlayerManager.Instance.findPlayer(param2);
         if(_loc4_ is SelfInfo)
         {
            return getSelfList(param1);
         }
         _loc3_ = _loc4_.gemstoneList;
         if(getPlaceByGemstonInitInfo(param1,_loc3_))
         {
            return getPlaceByGemstonInitInfo(param1,_loc3_).list;
         }
         return null;
      }
      
      public function setGemstoneListInfo(param1:GemstoneUpGradeInfo) : void
      {
         if(param1.equipPlace == 3)
         {
            faceList = param1.list;
         }
         else if(param1.equipPlace == 11)
         {
            suitList = param1.list;
         }
         else if(param1.equipPlace == 5)
         {
            glassList = param1.list;
         }
         else if(param1.equipPlace == 13)
         {
            decorationList = param1.list;
         }
         else if(param1.equipPlace == 2)
         {
            hariList = param1.list;
         }
      }
      
      public function getPlaceByGemstonInitInfo(param1:int, param2:Vector.<GemstonInitInfo>) : GemstonInitInfo
      {
         var _loc3_:int = 0;
         if(!param2 || param2.length <= 0)
         {
            return null;
         }
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            if(param2[_loc3_].equipPlace == param1)
            {
               return param2[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
   }
}
