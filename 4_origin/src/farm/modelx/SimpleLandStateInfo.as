package farm.modelx
{
   import ddt.manager.ItemManager;
   import ddt.manager.TimeManager;
   
   public class SimpleLandStateInfo
   {
       
      
      public var id:int;
      
      public var seedId:int;
      
      public var AccelerateDate:int;
      
      public var plantTime:Date;
      
      public var isStolen:Boolean = false;
      
      public function SimpleLandStateInfo()
      {
         super();
      }
      
      public function get hasPlantGrown() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(seedId == 0)
         {
            return false;
         }
         _loc3_ = parseInt(ItemManager.Instance.getTemplateById(seedId).Property3);
         _loc2_ = _loc3_ - AccelerateDate;
         _loc1_ = (TimeManager.Instance.Now().time - plantTime.time) / 60000;
         return _loc1_ >= _loc2_;
      }
   }
}
