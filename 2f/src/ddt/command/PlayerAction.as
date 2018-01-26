package ddt.command
{
   public class PlayerAction
   {
       
      
      public var type:String;
      
      public var stopAtEnd:Boolean;
      
      public var frames:Array;
      
      public var repeat:Boolean;
      
      public var replaceSame:Boolean;
      
      public function PlayerAction(param1:String, param2:Array, param3:Boolean, param4:Boolean, param5:Boolean){super();}
      
      public function canReplace(param1:PlayerAction) : Boolean{return false;}
      
      public function toString() : String{return null;}
   }
}
