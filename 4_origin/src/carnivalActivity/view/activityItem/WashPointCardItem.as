package carnivalActivity.view.activityItem
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.data.GiftBagInfo;
   
   public class WashPointCardItem extends UseUpEnergyItem
   {
      
      protected static var _wordArr:Array = ["一","两","三","四","五","六","七","八","九","十"];
       
      
      public function WashPointCardItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         if(_descTxt)
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt" + _type,_wordArr[_condtion - 1]);
            _descTxt.height = 40;
            _descTxt.y = _descTxt.y - 9;
         }
      }
   }
}
