package newOldPlayer{   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ClassUtils;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import flash.display.Sprite;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class NewOldPlayerManager extends EventDispatcher   {            private static var _instance:NewOldPlayerManager;                   private var _changeZoneTime:int;            private var _rechargeMoney:int;            private var _honorLevel:int;            private var _exchangeMoney:int;            private var _questID:Vector.<int>;            public function NewOldPlayerManager() { super(); }
            public static function get instance() : NewOldPlayerManager { return null; }
            public function get exchangeMoney() : int { return 0; }
            public function set exchangeMoney(value:int) : void { }
            public function get honorLevel() : int { return 0; }
            public function set honorLevel(value:int) : void { }
            public function get rechargeMoney() : int { return 0; }
            public function set rechargeMoney(value:int) : void { }
            public function get changeZoneTime() : int { return 0; }
            public function set changeZoneTime(value:int) : void { }
            public function isQuestFinished(questID:int) : Boolean { return false; }
            public function stup() : void { }
            private function __newOldPlayerHandler(e:PkgEvent) : void { }
            private function getQuestIDArray(str:String) : Vector.<int> { return null; }
            public function init() : void { }
            public function openView() : void { }
            private function showFrame() : void { }
   }}