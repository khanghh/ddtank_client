package ddt.data.goods
{
   import ddt.manager.PetInfoManager;
   import pet.data.PetSkill;
   import pet.data.PetSkillTemplateInfo;
   import pet.data.PetTemplateInfo;
   
   public class AwakenEquipInfo
   {
       
      
      private var _itemID:int;
      
      private var _belongPet:String;
      
      private var _belongPetId:int = -1;
      
      private var _skillId1:int;
      
      private var _skillId2:int;
      
      public function AwakenEquipInfo()
      {
         super();
      }
      
      public function get itemID() : int
      {
         return _itemID;
      }
      
      public function set itemID(param1:int) : void
      {
         _itemID = param1;
      }
      
      public function get belongPetName() : String
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(belongPetId > 0)
         {
            _loc1_ = PetInfoManager.getPetByKindID(belongPetId);
            _loc2_ = _loc1_.Name;
         }
         return _loc2_;
      }
      
      public function get belongPetId() : int
      {
         return _belongPetId;
      }
      
      public function set belongPetId(param1:int) : void
      {
         _belongPetId = param1;
      }
      
      public function set skillId1(param1:int) : void
      {
         _skillId1 = param1;
      }
      
      public function get skillId1() : int
      {
         return _skillId1;
      }
      
      public function set skillId2(param1:int) : void
      {
         _skillId2 = param1;
      }
      
      public function get skillId2() : int
      {
         return _skillId2;
      }
      
      public function getSkill1Info() : PetSkillTemplateInfo
      {
         if(skillId1 > 0)
         {
            return getSkillInfo(skillId1);
         }
         return null;
      }
      
      public function getSkill2Info() : PetSkillTemplateInfo
      {
         if(skillId2 > 0)
         {
            return getSkillInfo(skillId2);
         }
         return null;
      }
      
      private function getSkillInfo(param1:int) : PetSkillTemplateInfo
      {
         var _loc2_:PetSkillTemplateInfo = new PetSkill(param1);
         return _loc2_;
      }
   }
}
