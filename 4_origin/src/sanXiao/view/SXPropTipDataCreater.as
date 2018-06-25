package sanXiao.view
{
   import ddt.manager.LanguageMgr;
   import sanXiao.SanXiaoManager;
   
   public class SXPropTipDataCreater
   {
       
      
      private var _detailStringList:Array;
      
      public function SXPropTipDataCreater()
      {
         _detailStringList = ["","sanxiao.propCrossBomb.detail","sanxiao.propSquareBomb.detail","sanxiao.propClearColor.detail","sanxiao.propChangeColor.detail"];
         super();
      }
      
      public function getTipData(propType:int) : Object
      {
         var __detail:String = LanguageMgr.GetTranslation(_detailStringList[propType],SanXiaoManager.getInstance().getPropScore(propType));
         var __price:String = SanXiaoManager.getInstance().getPropPrice(propType).toString();
         var __isDiscount:Boolean = SanXiaoManager.getInstance().isDiscounts;
         var __curPrice:String = SanXiaoManager.getInstance().getPropCurPrice(propType);
         return {
            "detail":__detail,
            "price":__price,
            "isDiscount":__isDiscount,
            "curPrice":__curPrice
         };
      }
   }
}
