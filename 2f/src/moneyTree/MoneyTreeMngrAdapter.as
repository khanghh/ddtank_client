package moneyTree
{
   import ddt.events.PkgEvent;
   import moneyTree.model.MoneyTreeModel;
   
   public class MoneyTreeMngrAdapter extends MoneyTreeManager
   {
       
      
      public function MoneyTreeMngrAdapter(param1:inner){super(null);}
      
      override public function get model() : MoneyTreeModel{return null;}
      
      override public function setup() : void{}
      
      override public function onPkgUpdateInfo(param1:PkgEvent) : void{}
      
      override public function onPkgSendRedPkg(param1:PkgEvent) : void{}
      
      override public function onPkgSpeedUp(param1:PkgEvent) : void{}
      
      override public function getCurSpeedUpToMature() : String{return null;}
      
      override public function getCurSpeedUpOnce() : String{return null;}
      
      override public function showMainFrame() : void{}
      
      override protected function start() : void{}
      
      override public function hideMainFrame() : void{}
      
      override public function npcClicked() : void{}
      
      override public function inviteBtnClicked(param1:int, param2:String) : void{}
      
      override public function sendRedPkgBtnClicked() : void{}
      
      override public function pick(param1:int) : void{}
      
      override public function becomeMature() : void{}
      
      override public function onSpeedUpTypeSelected() : int{return 0;}
      
      override public function onSpeedUpClick(param1:int) : void{}
      
      override public function get positon() : int{return 0;}
      
      override public function dispose() : void{}
      
      override public function requirePick(param1:int) : void{}
      
      override public function requireUpdateInfo() : void{}
      
      override public function get isShowNPC() : Boolean{return false;}
   }
}
