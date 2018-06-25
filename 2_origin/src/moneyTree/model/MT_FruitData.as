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
         var remain:Number = timeGrown.time - TimeManager.Instance.Now().time;
         return remain <= 0;
      }
   }
}
