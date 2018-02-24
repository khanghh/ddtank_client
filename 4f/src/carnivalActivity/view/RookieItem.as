package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class RookieItem extends CarnivalActivityItem
   {
       
      
      private var _fightPower:int = -1;
      
      private var _fightPowerRankOne:int = -1;
      
      private var _fightPowerRankTwo:int = -1;
      
      public function RookieItem(param1:int, param2:GiftBagInfo, param3:int){super(null,null,null);}
      
      override protected function initData() : void{}
      
      override public function updateView() : void{}
   }
}
