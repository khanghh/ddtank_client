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
      
      public function getTipData(param1:int) : Object
      {
         var _loc4_:String = LanguageMgr.GetTranslation(_detailStringList[param1],SanXiaoManager.getInstance().getPropScore(param1));
         var _loc3_:String = SanXiaoManager.getInstance().getPropPrice(param1).toString();
         var _loc5_:Boolean = SanXiaoManager.getInstance().isDiscounts;
         var _loc2_:String = SanXiaoManager.getInstance().getPropCurPrice(param1);
         return {
            "detail":_loc4_,
            "price":_loc3_,
            "isDiscount":_loc5_,
            "curPrice":_loc2_
         };
      }
   }
}
