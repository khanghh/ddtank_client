package ddt.manager{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;      public class CheckWeaponManager   {            private static var _instance:CheckWeaponManager;                   private var _alert:BaseAlerFrame;            private var _skipCheck:Boolean;            private var _funcObject:Object;            private var _func:Function;            private var _funcArgs:Array;            public function CheckWeaponManager() { super(); }
            public static function get instance() : CheckWeaponManager { return null; }
            public function setFunction(funcObject:Object, func:Function = null, funcArgs:Array = null) : void { }
            public function isNoWeapon() : Boolean { return false; }
            public function isNoWeaponFragment() : Boolean { return false; }
            public function showFragmentAlert() : void { }
            private function onWeaponFragmentResponse(evt:FrameEvent) : void { }
            public function showGoShopAlert() : void { }
            private function __confirmToShopResponse(event:FrameEvent) : void { }
            public function showAlert() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function callBack() : void { }
   }}