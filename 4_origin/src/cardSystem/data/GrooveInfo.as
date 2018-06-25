package cardSystem.data
{
   import cardSystem.GrooveInfoManager;
   
   public class GrooveInfo
   {
       
      
      public var playerid:int;
      
      public var Place:int;
      
      public var Type:int;
      
      public var Level:int;
      
      public var GP:int;
      
      public var CardId:int;
      
      public function GrooveInfo()
      {
         super();
      }
      
      public function get realAttack() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Attack);
               i++;
            }
            return increate;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Attack);
      }
      
      public function get realDefence() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Defend);
               i++;
            }
            return increate;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Defend);
      }
      
      public function get realAgility() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Agility);
               i++;
            }
            return increate;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Agility);
      }
      
      public function get realLucky() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Lucky);
               i++;
            }
            return increate;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Lucky);
      }
      
      public function get realDamage() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Damage);
               i++;
            }
            return increate;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Damage);
      }
      
      public function get realGuard() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Guard);
               i++;
            }
            return increate;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(i),String(Type)).Guard);
      }
   }
}
