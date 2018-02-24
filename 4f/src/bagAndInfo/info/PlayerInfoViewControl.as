package bagAndInfo.info
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperDataModuleLoad;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   
   public class PlayerInfoViewControl
   {
      
      private static var _view:PlayerInfoFrame;
      
      private static var _tempInfo:PlayerInfo;
      
      public static var isOpenFromBag:Boolean;
      
      public static var isOpenFromBattle:Boolean;
      
      public static var _isBattle:Boolean;
      
      public static var currentPlayer:PlayerInfo;
       
      
      public function PlayerInfoViewControl(){super();}
      
      public static function view(param1:*, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : void{}
      
      private static function loadDataComplete(param1:*, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : void{}
      
      private static function loadModule(param1:*, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : void{}
      
      private static function loadComplete(param1:*, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : void{}
      
      private static function __infoChange(param1:PlayerPropertyEvent) : void{}
      
      public static function viewByID(param1:int, param2:int = -1, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : void{}
      
      public static function viewByNickName(param1:String, param2:int = -1, param3:Boolean = true) : void{}
      
      private static function __IDChange(param1:PlayerPropertyEvent) : void{}
      
      private static function __responseHandler(param1:FrameEvent) : void{}
      
      public static function closeView() : void{}
      
      public static function clearView() : void{}
   }
}
