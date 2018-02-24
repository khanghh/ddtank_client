package ddt.events
{
   import road7th.comm.PackageIn;
   
   public class PkgEvent extends CrazyTankSocketEvent
   {
       
      
      public function PkgEvent(param1:String, param2:PackageIn){super(null,null);}
      
      public static function format(... rest) : String{return null;}
   }
}
