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
      
      public function Pet(param1:PetInfo){super();}
      
      public function get petInfo() : PetInfo{return null;}
      
      public function get MP() : int{return 0;}
      
      public function set MP(param1:int) : void{}
      
      public function get MaxMP() : int{return 0;}
      
      public function set MaxMP(param1:int) : void{}
      
      public function get equipedSkillIDs() : Array{return null;}
      
      public function useSkill(param1:int, param2:Boolean) : void{}
      
      public function get petBeatInfo() : Dictionary{return null;}
   }
}
