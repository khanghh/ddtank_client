package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class BuildUpgradeItem extends CarnivalActivityItem
   {
      
      protected static var BUILDLEN:int = 14;
       
      
      protected var _templeGrade:int;
      
      private var offset:int;
      
      private var index:int;
      
      public function BuildUpgradeItem(param1:int, param2:GiftBagInfo, param3:int){super(null,null,null);}
      
      override protected function initItem() : void{}
      
      override public function updateView() : void{}
   }
}
