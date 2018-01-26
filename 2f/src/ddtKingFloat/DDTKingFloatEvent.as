package ddtKingFloat
{
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class DDTKingFloatEvent extends Event
   {
      
      public static const FLOATPARADE_OPENVIEW:String = "floatparadeOpenView";
      
      public static const FLOATPARADE_PKG:String = "floatparadepkg";
       
      
      public var data:Object;
      
      public var savePkg:PackageIn;
      
      public function DDTKingFloatEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
