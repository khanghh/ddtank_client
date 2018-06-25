package totem
{
   import ddt.data.Experience;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperDataModuleLoad;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import totem.data.TotemAddInfo;
   import totem.data.TotemDataAnalyz;
   import totem.data.TotemDataVo;
   import totem.data.TotemUpGradDataVo;
   import totem.data.TotemUpGradeAnalyz;
   
   public class TotemManager extends EventDispatcher
   {
      
      public static const INFO_VIEW:String = "infoview";
      
      public static const TOTEM_VIEW:String = "totemview";
      
      public static const SET_VISIBLE:String = "setvisible";
      
      public static const UPDATE_UPGRADE:String = "updateUpGrade";
      
      private static var _instance:TotemManager;
       
      
      public var isBindInNoPrompt:Boolean;
      
      public var isDonotPromptActPro:Boolean = true;
      
      public var isSelectedActPro:Boolean;
      
      private var _dataList:Object;
      
      private var _dataList2:Object;
      
      private var _upGradeData:DictionaryData;
      
      private var _totemGrades:DictionaryData;
      
      private var cevent:CEvent;
      
      public function TotemManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : TotemManager
      {
         if(_instance == null)
         {
            _instance = new TotemManager();
         }
         return _instance;
      }
      
      public function showView($type:String, data:Object) : void
      {
         data.type = "openview";
         cevent = new CEvent($type,data);
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createHonorUpTemplateLoader],loadUIModule);
      }
      
      private function loadUIModule() : void
      {
         AssetModuleLoader.addModelLoader("totem",7);
         AssetModuleLoader.startCodeLoader(loadComplete);
      }
      
      private function loadComplete() : void
      {
         dispatchEvent(cevent);
      }
      
      public function setVisible($type:String, $visible:Boolean) : void
      {
         dispatchEvent(new CEvent($type,{
            "type":"setvisible",
            "visible":$visible
         }));
      }
      
      public function closeView($type:String) : void
      {
         dispatchEvent(new CEvent($type,{"type":"closeView"}));
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(619),__onTotemUpGradeInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(617),__onTotemUpGradeUpdate);
      }
      
      private function __onTotemUpGradeInfo(evt:PkgEvent) : void
      {
         var totemPage:int = 0;
         var grades:int = 0;
         var i:int = 0;
         _totemGrades = new DictionaryData();
         var pkg:PackageIn = evt.pkg;
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            totemPage = pkg.readInt();
            grades = pkg.readInt();
            _totemGrades.add(totemPage,grades);
            i++;
         }
      }
      
      private function __onTotemUpGradeUpdate(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var totemPage:int = pkg.readInt();
         var grades:int = pkg.readInt();
         if(!_totemGrades.hasKey(totemPage))
         {
            _totemGrades.add(totemPage,grades);
         }
         else
         {
            _totemGrades[totemPage] = grades;
         }
         this.dispatchEvent(new CEvent("updateUpGrade",totemPage));
      }
      
      public function getGradeByTotemPage(page:int) : int
      {
         if(_totemGrades.hasKey(page))
         {
            return _totemGrades[page];
         }
         return 0;
      }
      
      public function getTotemAddAllProByProType(maxTotemID:int) : TotemAddInfo
      {
         return otherPlayerTotemAllPro(maxTotemID,_totemGrades);
      }
      
      public function otherPlayerTotemAllPro(maxTotemID:int, grades:DictionaryData) : TotemAddInfo
      {
         var proValue:* = null;
         var grade:int = 0;
         var add:Number = NaN;
         var upGradeVo:* = null;
         var page:int = 0;
         var temLev:int = 0;
         if(grades == null)
         {
            return null;
         }
         var totalProValue:TotemAddInfo = new TotemAddInfo();
         var maxLev:int = TotemManager.instance.getTotemPointLevel(maxTotemID);
         for(page = 1; page <= 5; )
         {
            temLev = Math.min(maxLev,page * 70);
            proValue = getAddInfo(temLev,(page - 1) * 70 + 1);
            if(grades.hasKey(page))
            {
               grade = grades[page];
               upGradeVo = getUpGradeInfo(page,grade);
               add = upGradeVo.data / 1000;
               proValue.addGradePro(add);
            }
            totalProValue.add(proValue);
            page++;
         }
         return totalProValue;
      }
      
      public function inittotmeData(analyzer:TotemDataAnalyz) : void
      {
         _dataList = analyzer.dataList;
         _dataList2 = analyzer.dataList2;
      }
      
      public function upGradeData(analyzer:TotemUpGradeAnalyz) : void
      {
         _upGradeData = analyzer.dataList;
      }
      
      public function getUpGradeInfo(page:int, grade:int) : TotemUpGradDataVo
      {
         var temInfo:* = null;
         var grades:* = null;
         var i:int = 0;
         if(_upGradeData && _upGradeData.length > 0)
         {
            if(_upGradeData.hasKey(page))
            {
               grades = _upGradeData[page] as Array;
               for(i = 0; i < grades.length; )
               {
                  temInfo = grades[i] as TotemUpGradDataVo;
                  if(temInfo && temInfo.grades == grade)
                  {
                     return temInfo;
                  }
                  i++;
               }
            }
         }
         return null;
      }
      
      public function getCurInfoByLevel(totemLevel:int) : TotemDataVo
      {
         return _dataList2[totemLevel];
      }
      
      public function getCurInfoById(id:int) : TotemDataVo
      {
         if(id == 0)
         {
            return new TotemDataVo();
         }
         return _dataList[id];
      }
      
      public function getNextInfoByLevel(totemLevel:int) : TotemDataVo
      {
         return _dataList2[totemLevel + 1];
      }
      
      public function getNextInfoById(id:int) : TotemDataVo
      {
         var level:int = 0;
         if(id == 0)
         {
            level = 0;
         }
         else
         {
            level = _dataList[id].Point;
         }
         return _dataList2[level + 1];
      }
      
      public function getAddInfo(totemLevel:int, startTotemLevel:int = 1) : TotemAddInfo
      {
         var totemAddInfo:TotemAddInfo = new TotemAddInfo();
         var _loc6_:int = 0;
         var _loc5_:* = _dataList;
         for each(var tmpVo in _dataList)
         {
            if(tmpVo.Point <= totemLevel && tmpVo.Point >= startTotemLevel)
            {
               totemAddInfo.Agility = totemAddInfo.Agility + tmpVo.AddAgility;
               totemAddInfo.Attack = totemAddInfo.Attack + tmpVo.AddAttack;
               totemAddInfo.Blood = totemAddInfo.Blood + tmpVo.AddBlood;
               totemAddInfo.Damage = totemAddInfo.Damage + tmpVo.AddDamage;
               totemAddInfo.Defence = totemAddInfo.Defence + tmpVo.AddDefence;
               totemAddInfo.Guard = totemAddInfo.Guard + tmpVo.AddGuard;
               totemAddInfo.Luck = totemAddInfo.Luck + tmpVo.AddLuck;
            }
         }
         return totemAddInfo;
      }
      
      public function getTotemPointLevel(id:int) : int
      {
         if(id == 0)
         {
            return 0;
         }
         return _dataList[id].Point;
      }
      
      public function get usableGP() : int
      {
         return PlayerManager.Instance.Self.GP - Experience.expericence[PlayerManager.Instance.Self.Grade - 1];
      }
      
      public function getCurrentLv(totemLevel:int) : int
      {
         return int(totemLevel / 7);
      }
      
      public function updatePropertyAddtion(totemId:int, dic:DictionaryData, grades:DictionaryData) : void
      {
         if(!dic["Attack"])
         {
            return;
         }
         var totemAddInfo:TotemAddInfo = grades == null?getTotemAddAllProByProType(totemId):otherPlayerTotemAllPro(totemId,grades);
         if(totemAddInfo == null)
         {
            return;
         }
         dic["Attack"]["Totem"] = totemAddInfo.Attack;
         dic["Defence"]["Totem"] = totemAddInfo.Defence;
         dic["Agility"]["Totem"] = totemAddInfo.Agility;
         dic["Luck"]["Totem"] = totemAddInfo.Luck;
         dic["HP"]["Totem"] = totemAddInfo.Blood;
         dic["Damage"]["Totem"] = totemAddInfo.Damage;
         dic["Armor"]["Totem"] = totemAddInfo.Guard;
      }
      
      public function getSamePageLocationList(page:int, location:int) : Array
      {
         var dataArray:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _dataList;
         for each(var tmp in _dataList)
         {
            if(tmp.Page == page && tmp.Location == location)
            {
               dataArray.push(tmp);
            }
         }
         dataArray.sortOn("Layers",16);
         return dataArray;
      }
   }
}
