package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class TurnRoundEggItem extends CarnivalActivityItem
   {
       
      
      protected var _remain:int;
      
      public function TurnRoundEggItem(param1:int, param2:GiftBagInfo, param3:int){super(null,null,null);}
      
      override protected function initItem() : void{}
      
      override protected function initData() : void{}
      
      override public function updateView() : void{}
   }
}
