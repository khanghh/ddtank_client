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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Level != 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ <= Level)
            {
               _loc1_ = _loc1_ + int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Attack);
               _loc2_++;
            }
            return _loc1_;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Attack);
      }
      
      public function get realDefence() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Level != 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ <= Level)
            {
               _loc1_ = _loc1_ + int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Defend);
               _loc2_++;
            }
            return _loc1_;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Defend);
      }
      
      public function get realAgility() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Level != 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ <= Level)
            {
               _loc1_ = _loc1_ + int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Agility);
               _loc2_++;
            }
            return _loc1_;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Agility);
      }
      
      public function get realLucky() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Level != 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ <= Level)
            {
               _loc1_ = _loc1_ + int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Lucky);
               _loc2_++;
            }
            return _loc1_;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Lucky);
      }
      
      public function get realDamage() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Level != 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ <= Level)
            {
               _loc1_ = _loc1_ + int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Damage);
               _loc2_++;
            }
            return _loc1_;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Damage);
      }
      
      public function get realGuard() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Level != 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ <= Level)
            {
               _loc1_ = _loc1_ + int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Guard);
               _loc2_++;
            }
            return _loc1_;
         }
         return int(GrooveInfoManager.instance.getInfoByLevel(String(_loc2_),String(Type)).Guard);
      }
   }
}
