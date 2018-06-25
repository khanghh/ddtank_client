package explorerManual.data
{
   import explorerManual.data.model.ManualItemInfo;
   
   public class ManualLevelProInfo
   {
       
      
      public var name:String;
      
      public var magicAttack:int;
      
      public var magicResistance:int;
      
      private var _boost:int;
      
      public function ManualLevelProInfo()
      {
         super();
      }
      
      public function get boost() : int
      {
         return _boost;
      }
      
      public function set boost(value:int) : void
      {
         _boost = value;
      }
      
      public function update(info:ManualItemInfo) : void
      {
         this.magicAttack = info.MagicAttack;
         this.magicResistance = info.MagicResistance;
         this.boost = info.Boost;
         this.name = info.Name;
      }
   }
}
