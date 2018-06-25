package moneyTree{   import ddt.events.PkgEvent;   import moneyTree.model.MoneyTreeModel;      public class MoneyTreeMngrAdapter extends MoneyTreeManager   {                   public function MoneyTreeMngrAdapter(single:inner) { super(null); }
            override public function get model() : MoneyTreeModel { return null; }
            override public function setup() : void { }
            override public function onPkgUpdateInfo(e:PkgEvent) : void { }
            override public function onPkgSendRedPkg(e:PkgEvent) : void { }
            override public function onPkgSpeedUp(e:PkgEvent) : void { }
            override public function getCurSpeedUpToMature() : String { return null; }
            override public function getCurSpeedUpOnce() : String { return null; }
            override public function showMainFrame() : void { }
            override protected function start() : void { }
            override public function hideMainFrame() : void { }
            override public function npcClicked() : void { }
            override public function inviteBtnClicked($id:int, type:String) : void { }
            override public function sendRedPkgBtnClicked() : void { }
            override public function pick($index:int) : void { }
            override public function becomeMature() : void { }
            override public function onSpeedUpTypeSelected() : int { return 0; }
            override public function onSpeedUpClick(index:int) : void { }
            override public function get positon() : int { return 0; }
            override public function dispose() : void { }
            override public function requirePick(_index:int) : void { }
            override public function requireUpdateInfo() : void { }
            override public function get isShowNPC() : Boolean { return false; }
   }}