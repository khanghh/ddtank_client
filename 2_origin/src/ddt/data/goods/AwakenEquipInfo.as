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
      
      public function set itemID(value:int) : void
      {
         _itemID = value;
      }
      
      public function get belongPetName() : String
      {
         var petName:* = null;
         var petData:* = null;
         if(belongPetId > 0)
         {
            petData = PetInfoManager.getPetByKindID(belongPetId);
            petName = petData.Name;
         }
         return petName;
      }
      
      public function get belongPetId() : int
      {
         return _belongPetId;
      }
      
      public function set belongPetId(value:int) : void
      {
         _belongPetId = value;
      }
      
      public function set skillId1(id:int) : void
      {
         _skillId1 = id;
      }
      
      public function get skillId1() : int
      {
         return _skillId1;
      }
      
      public function set skillId2(id:int) : void
      {
         _skillId2 = id;
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
      
      private function getSkillInfo(skillId:int) : PetSkillTemplateInfo
      {
         var info:PetSkillTemplateInfo = new PetSkill(skillId);
         return info;
      }
   }
}
