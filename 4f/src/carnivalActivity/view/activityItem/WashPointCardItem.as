package carnivalActivity.view.activityItem
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.data.GiftBagInfo;
   
   public class WashPointCardItem extends UseUpEnergyItem
   {
      
      protected static var _wordArr:Array = ["一","两","三","四","五","六","七","八","九","十"];
       
      
      public function WashPointCardItem(param1:int, param2:GiftBagInfo, param3:int){super(null,null,null);}
      
      override protected function initItem() : void{}
   }
}
