package texpSystem
{
   import flash.events.Event;
   
   public class TexpEvent extends Event
   {
      
      public static const TEXP_HP:String = "texpHp";
      
      public static const TEXP_ATT:String = "texpAtt";
      
      public static const TEXP_DEF:String = "texpDef";
      
      public static const TEXP_SPD:String = "texpSpd";
      
      public static const TEXP_LUK:String = "texpLuk";
      
      public static const TEXP_MAGIC_ATK:String = "texpMagicAtk";
      
      public static const TEXP_MAGIC_DEF:String = "texpMagicDef";
       
      
      public function TexpEvent(param1:String)
      {
         super(param1);
      }
   }
}
