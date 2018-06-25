package exchangeAct{   import com.pickgliss.ui.controls.SimpleBitmapButton;   import ddt.CoreManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import flash.utils.Dictionary;   import hall.HallStateView;   import hallIcon.HallIconManager;   import wonderfulActivity.WonderfulActivityManager;      public class ExchangeActManager extends CoreManager   {            private static var _instance:ExchangeActManager;                   private var _wonderfulIcon:SimpleBitmapButton;            private var _hallView:HallStateView;            public function ExchangeActManager() { super(); }
            public static function get Instance() : ExchangeActManager { return null; }
            public function addWonderfulIcon(hallView:HallStateView) : void { }
            public function creatWonderfulIcon() : void { }
            public function onWonderfulClick() : void { }
            public function deleteWonderfulIcon() : void { }
   }}