package explorerManual.data
{
   import explorerManual.data.model.ManualItemInfo;
   
   public class ManualLevelProInfo
   {
       
      
      public var name:String;
      
      public var magicAttack:int;
      
      public var magicResistance:int;
      
      private var _boost:int;
      
      public function ManualLevelProInfo(){super();}
      
      public function get boost() : int{return 0;}
      
      public function set boost(param1:int) : void{}
      
      public function update(param1:ManualItemInfo) : void{}
   }
}
