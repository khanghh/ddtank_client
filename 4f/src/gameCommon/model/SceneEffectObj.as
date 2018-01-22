package gameCommon.model
{
   public class SceneEffectObj
   {
      
      public static var Null:int = 0;
      
      public static var BlackHole:int = -1;
      
      public static var RedDead:int = -2;
      
      public static var Bomb:int = -3;
      
      public static var Star:int = -4;
      
      public static var Fire:int = -101;
      
      public static var Thunder:int = -102;
      
      public static var Guide:int = -103;
      
      public static var Hide:int = -104;
       
      
      public var id:int;
      
      public var x:int;
      
      public var y:int;
      
      public var follow:Boolean;
      
      public var turn:int;
      
      public function SceneEffectObj(){super();}
   }
}
