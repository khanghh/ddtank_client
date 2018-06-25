package ddt.events
{
   import road7th.comm.PackageIn;
   
   public class PkgEvent extends CrazyTankSocketEvent
   {
       
      
      public function PkgEvent(type:String, pkg:PackageIn)
      {
         super(type,pkg);
      }
      
      public static function format(... args) : String
      {
         var i:int = 0;
         var strArr:Array = [];
         for(i = 0; i < args.length; )
         {
            strArr.push(args[i].toString(16));
            i++;
         }
         return strArr.join("+");
      }
   }
}
