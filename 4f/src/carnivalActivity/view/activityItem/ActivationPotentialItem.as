package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class ActivationPotentialItem extends CarnivalActivityItem
   {
      
      protected static var PROLEN:int = 5;
       
      
      protected var _proOffset:int;
      
      protected var _goodIndex:int;
      
      public function ActivationPotentialItem(param1:int, param2:GiftBagInfo, param3:int){super(null,null,null);}
      
      override protected function initItem() : void{}
      
      override public function updateView() : void{}
   }
}
