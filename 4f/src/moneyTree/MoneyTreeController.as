package moneyTree{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreController;   import ddt.ICoreCtrller;   import ddt.events.CEvent;   import ddt.utils.HelperUIModuleLoad;   import moneyTree.view.MoneyTreeMainFrame;      public class MoneyTreeController extends CoreController implements ICoreCtrller   {            private static var instance:MoneyTreeController;                   private var _manager:MoneyTreeManager;            private var _frame:MoneyTreeMainFrame;            public function MoneyTreeController() { super(); }
            public static function getInstance() : MoneyTreeController { return null; }
            public function setup() : void { }
            override protected function eventsHandler(e:CEvent) : void { }
            private function onSpeedUpSuc() : void { }
            private function onPick(index:int) : void { }
            private function resetFriendList() : void { }
            private function updateRemainNum() : void { }
            private function updateViewByInfo() : void { }
            private function hideMainFrame() : void { }
            private function showMainFrame() : void { }
            private function onLoaded() : void { }
            private function setFocus() : void { }
            public function BecomeMature() : void { }
   }}