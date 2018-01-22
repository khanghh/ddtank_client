package moneyTree.model
{
   import ddt.manager.TimeManager;
   
   public class MT_FruitData
   {
       
      
      public var timeGrown:Date;
      
      public var priceSpeedUp:int;
      
      public function MT_FruitData()
      {
         super();
      }
      
      public function get isGrown() : Boolean
      {
         if(!timeGrown)
         {
            return false;
         }
         var _loc1_:Number = timeGrown.time - TimeManager.Instance.Now().time;
         return _loc1_ <= 0;
      }
   }
}
