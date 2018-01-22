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
      
      public function SimpleLandStateInfo(){super();}
      
      public function get hasPlantGrown() : Boolean{return false;}
   }
}
