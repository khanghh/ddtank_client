package totem{   import ddt.data.Experience;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.HelperDataModuleLoad;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import totem.data.TotemAddInfo;   import totem.data.TotemDataAnalyz;   import totem.data.TotemDataVo;   import totem.data.TotemUpGradDataVo;   import totem.data.TotemUpGradeAnalyz;      public class TotemManager extends EventDispatcher   {            public static const INFO_VIEW:String = "infoview";            public static const TOTEM_VIEW:String = "totemview";            public static const SET_VISIBLE:String = "setvisible";            public static const UPDATE_UPGRADE:String = "updateUpGrade";            private static var _instance:TotemManager;                   public var isBindInNoPrompt:Boolean;            public var isDonotPromptActPro:Boolean = true;            public var isSelectedActPro:Boolean;            private var _dataList:Object;            private var _dataList2:Object;            private var _upGradeData:DictionaryData;            private var _totemGrades:DictionaryData;            private var cevent:CEvent;            public function TotemManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : TotemManager { return null; }
            public function showView($type:String, data:Object) : void { }
            private function loadUIModule() : void { }
            private function loadComplete() : void { }
            public function setVisible($type:String, $visible:Boolean) : void { }
            public function closeView($type:String) : void { }
            public function setup() : void { }
            private function __onTotemUpGradeInfo(evt:PkgEvent) : void { }
            private function __onTotemUpGradeUpdate(evt:PkgEvent) : void { }
            public function getGradeByTotemPage(page:int) : int { return 0; }
            public function getTotemAddAllProByProType(maxTotemID:int) : TotemAddInfo { return null; }
            public function otherPlayerTotemAllPro(maxTotemID:int, grades:DictionaryData) : TotemAddInfo { return null; }
            public function inittotmeData(analyzer:TotemDataAnalyz) : void { }
            public function upGradeData(analyzer:TotemUpGradeAnalyz) : void { }
            public function getUpGradeInfo(page:int, grade:int) : TotemUpGradDataVo { return null; }
            public function getCurInfoByLevel(totemLevel:int) : TotemDataVo { return null; }
            public function getCurInfoById(id:int) : TotemDataVo { return null; }
            public function getNextInfoByLevel(totemLevel:int) : TotemDataVo { return null; }
            public function getNextInfoById(id:int) : TotemDataVo { return null; }
            public function getAddInfo(totemLevel:int, startTotemLevel:int = 1) : TotemAddInfo { return null; }
            public function getTotemPointLevel(id:int) : int { return 0; }
            public function get usableGP() : int { return 0; }
            public function getCurrentLv(totemLevel:int) : int { return 0; }
            public function updatePropertyAddtion(totemId:int, dic:DictionaryData, grades:DictionaryData) : void { }
            public function getSamePageLocationList(page:int, location:int) : Array { return null; }
   }}