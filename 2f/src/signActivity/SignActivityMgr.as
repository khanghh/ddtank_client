package signActivity{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.CoreManager;   import ddt.manager.LanguageMgr;   import ddt.utils.HelperUIModuleLoad;   import hallIcon.HallIconManager;   import signActivity.model.SignActivityModel;   import signActivity.view.SignActivityFrame;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.data.GiftBagInfo;   import wonderfulActivity.data.GmActivityInfo;      public class SignActivityMgr extends CoreManager   {            private static var _instance:SignActivityMgr;                   private var _frame:SignActivityFrame;            private var _model:SignActivityModel;            private var _isOpen:Boolean = false;            public function SignActivityMgr() { super(); }
            public static function get instance() : SignActivityMgr { return null; }
            public function setup() : void { }
            public function get model() : SignActivityModel { return null; }
            override protected function start() : void { }
            private function onLoaded() : void { }
            private function findSignActivityType(array:Array) : int { return 0; }
            public function showIcon() : void { }
            public function get isOpen() : Boolean { return false; }
            public function set isOpen(value:Boolean) : void { }
   }}