package totem
{
   import ddt.data.Experience;
   import ddt.events.CEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperDataModuleLoad;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   import totem.data.TotemAddInfo;
   import totem.data.TotemDataAnalyz;
   import totem.data.TotemDataVo;
   
   public class TotemManager extends EventDispatcher
   {
      
      public static const INFO_VIEW:String = "infoview";
      
      public static const TOTEM_VIEW:String = "totemview";
      
      public static const SET_VISIBLE:String = "setvisible";
      
      private static var _instance:TotemManager;
       
      
      public var isBindInNoPrompt:Boolean;
      
      public var isDonotPromptActPro:Boolean = true;
      
      public var isSelectedActPro:Boolean;
      
      private var _dataList:Object;
      
      private var _dataList2:Object;
      
      private var cevent:CEvent;
      
      public function TotemManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : TotemManager{return null;}
      
      public function showView(param1:String, param2:Object) : void{}
      
      private function loadUIModule() : void{}
      
      private function loadComplete() : void{}
      
      public function setVisible(param1:String, param2:Boolean) : void{}
      
      public function closeView(param1:String) : void{}
      
      public function setup(param1:TotemDataAnalyz) : void{}
      
      public function getCurInfoByLevel(param1:int) : TotemDataVo{return null;}
      
      public function getCurInfoById(param1:int) : TotemDataVo{return null;}
      
      public function getNextInfoByLevel(param1:int) : TotemDataVo{return null;}
      
      public function getNextInfoById(param1:int) : TotemDataVo{return null;}
      
      public function getAddInfo(param1:int, param2:int = 1) : TotemAddInfo{return null;}
      
      public function getTotemPointLevel(param1:int) : int{return 0;}
      
      public function get usableGP() : int{return 0;}
      
      public function getCurrentLv(param1:int) : int{return 0;}
      
      public function updatePropertyAddtion(param1:int, param2:DictionaryData) : void{}
      
      public function getSamePageLocationList(param1:int, param2:int) : Array{return null;}
   }
}
