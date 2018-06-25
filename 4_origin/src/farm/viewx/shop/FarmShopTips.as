package farm.viewx.shop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.view.tips.GoodTip;
   
   public class FarmShopTips extends GoodTip
   {
       
      
      private var _limitTips:String;
      
      public function FarmShopTips()
      {
         super();
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data)
         {
            _limitTips = data.limitTips;
            .super.tipData = data.shopItemInfo;
         }
      }
      
      public function limitTips(value:String) : void
      {
         _limitTips = value;
      }
      
      override protected function updateView() : void
      {
         if(_info == null)
         {
            return;
         }
         clear();
         _isArmed = false;
         createItemName();
         createQualityItem();
         createCategoryItem();
         seperateLine();
         createDescript();
         seperateLine();
         createLimitTips();
         addChildren();
      }
      
      private function createLimitTips() : void
      {
         var tips:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.DescriptionTxt");
         tips.width = 180;
         tips.text = _limitTips;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = tips;
      }
   }
}
