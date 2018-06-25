package pet.data
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class PetTemplateInfo extends EventDispatcher
   {
       
      
      public var CollectID:int;
      
      public var TemplateID:int;
      
      public var Name:String = "";
      
      public var KindID:int;
      
      public var Description:String;
      
      public var RareLevel:int;
      
      public var StarLevel:int;
      
      private var _GameAssetUrl:String;
      
      public var Pic:String;
      
      public var MP:int;
      
      public var HighAttack:int;
      
      public var HighDefence:int;
      
      public var HighAgility:int;
      
      public var HighLuck:int;
      
      public var HighBlood:int;
      
      public var HighDamage:int;
      
      public var HighGuard:int;
      
      public var LowBloodGrow:int;
      
      public var LowAttackGrow:int;
      
      public var LowDefenceGrow:int;
      
      public var LowAgilityGrow:int;
      
      public var LowLuckGrow:int;
      
      public var HighAttackGrow:int;
      
      public var HighDefenceGrow:int;
      
      public var HighAgilityGrow:int;
      
      public var HighLuckGrow:int;
      
      public var HighBloodGrow:int;
      
      public var HighDamageGrow:int;
      
      public var HighGuardGrow:int;
      
      private var _washGetCount:int;
      
      public function PetTemplateInfo(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function get GameAssetUrl() : String
      {
         return _GameAssetUrl;
      }
      
      public function set GameAssetUrl(value:String) : void
      {
         _GameAssetUrl = value;
      }
      
      public function get WashGetCount() : int
      {
         return _washGetCount;
      }
      
      public function set WashGetCount(value:int) : void
      {
         _washGetCount = value;
      }
   }
}
