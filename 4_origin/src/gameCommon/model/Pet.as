package gameCommon.model
{
   import ddt.events.LivingEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import pet.data.PetInfo;
   
   public class Pet extends EventDispatcher
   {
       
      
      private var _MP:int;
      
      private var _maxMP:int = 100;
      
      private var _petInfo:PetInfo;
      
      private var _petBeatInfo:Dictionary;
      
      public function Pet(petInfo:PetInfo)
      {
         _petBeatInfo = new Dictionary();
         super();
         _petInfo = petInfo;
      }
      
      public function get petInfo() : PetInfo
      {
         return _petInfo;
      }
      
      public function get MP() : int
      {
         return _MP;
      }
      
      public function set MP(value:int) : void
      {
         if(value == _MP)
         {
            return;
         }
         _MP = value;
         dispatchEvent(new LivingEvent("petEnergyChange"));
      }
      
      public function get MaxMP() : int
      {
         return _maxMP;
      }
      
      public function set MaxMP(value:int) : void
      {
         _maxMP = value;
      }
      
      public function get equipedSkillIDs() : Array
      {
         return _petInfo.equipdSkills.list;
      }
      
      public function useSkill(skillID:int, isUsed:Boolean) : void
      {
         dispatchEvent(new LivingEvent("usePetSkill",skillID));
      }
      
      public function get petBeatInfo() : Dictionary
      {
         return _petBeatInfo;
      }
   }
}
