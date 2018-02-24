package pet.data
{
   import flash.events.EventDispatcher;
   
   public class PetAllSkillTemplateInfo extends EventDispatcher
   {
       
      
      public var PetTemplateID:int;
      
      public var KindID:int;
      
      public var GetType:int;
      
      public var SkillID:int;
      
      public var SkillBookID:int;
      
      public var MinLevel:int;
      
      public var DeleteSkillIDs:String;
      
      public function PetAllSkillTemplateInfo(){super();}
   }
}
