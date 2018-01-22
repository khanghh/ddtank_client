package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.QualityType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class DailyGiftItem extends CarnivalActivityItem
   {
       
      
      private var _count:int;
      
      private var _temId:int;
      
      private var _getGoodsType:int;
      
      private var _beadGrade:int;
      
      private var _magicStoneQuality:int;
      
      private var _actType:int;
      
      public function DailyGiftItem(param1:int, param2:GiftBagInfo, param3:int){super(null,null,null);}
      
      override protected function initItem() : void{}
      
      override public function updateView() : void{}
   }
}
