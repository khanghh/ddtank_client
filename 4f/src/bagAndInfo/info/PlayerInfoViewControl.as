package bagAndInfo.info{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import ddt.data.player.PlayerInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.HelperDataModuleLoad;   import petsBag.petsAdvanced.PetsAdvancedManager;      public class PlayerInfoViewControl   {            private static var _view:PlayerInfoFrame;            private static var _tempInfo:PlayerInfo;            public static var isOpenFromBag:Boolean;            public static var isOpenFromBattle:Boolean;            public static var _isBattle:Boolean;            public static var currentPlayer:PlayerInfo;                   public function PlayerInfoViewControl() { super(); }
            public static function view(info:*, achivEnable:Boolean = true, bool:Boolean = false, isBombKing:Boolean = false) : void { }
            private static function loadDataComplete(info:*, achivEnable:Boolean = true, bool:Boolean = false, isBombKing:Boolean = false) : void { }
            private static function loadModule(info:*, achivEnable:Boolean = true, bool:Boolean = false, isBombKing:Boolean = false) : void { }
            private static function loadComplete(info:*, achivEnable:Boolean = true, bool:Boolean = false, isBombKing:Boolean = false) : void { }
            private static function __infoChange(evt:PlayerPropertyEvent) : void { }
            public static function viewByID(id:int, zoneID:int = -1, achivEnable:Boolean = true, _isbattle:Boolean = false, isBombKing:Boolean = false) : void { }
            public static function viewByNickName(nickName:String, zoneID:int = -1, achivEnable:Boolean = true) : void { }
            private static function __IDChange(evt:PlayerPropertyEvent) : void { }
            private static function __responseHandler(evt:FrameEvent) : void { }
            public static function closeView() : void { }
            public static function clearView() : void { }
   }}