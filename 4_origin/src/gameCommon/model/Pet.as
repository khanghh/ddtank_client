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
      
      public function Pet(param1:PetInfo)
      {
         _petBeatInfo = new Dictionary();
         super();
         _petInfo = param1;
      }
      
      public function get petInfo() : PetInfo
      {
         return _petInfo;
      }
      
      public function get MP() : int
      {
         return _MP;
      }
      
      public function set MP(param1:int) : void
      {
         if(param1 == _MP)
         {
            return;
         }
         _MP = param1;
         dispatchEvent(new LivingEvent("petEnergyChange"));
      }
      
      public function get MaxMP() : int
      {
         return _maxMP;
      }
      
      public function set MaxMP(param1:int) : void
      {
         _maxMP = param1;
      }
      
      public function get equipedSkillIDs() : Array
      {
         return _petInfo.equipdSkills.list;
      }
      
      public function useSkill(param1:int, param2:Boolean) : void
      {
         dispatchEvent(new LivingEvent("usePetSkill",param1));
      }
      
      public function get petBeatInfo() : Dictionary
      {
         return _petBeatInfo;
      }
   }
}
