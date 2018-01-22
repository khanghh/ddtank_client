package floatParade
{
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class FloatParadeEvent extends Event
   {
      
      public static const FLOATPARADE_OPENVIEW:String = "floatparadeOpenView";
      
      public static const FLOATPARADE_PKG:String = "floatparadepkg";
       
      
      public var data:Object;
      
      public var savePkg:PackageIn;
      
      public function FloatParadeEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
