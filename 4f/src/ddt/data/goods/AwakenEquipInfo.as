package ddt.data.goods{   import ddt.manager.PetInfoManager;   import pet.data.PetSkill;   import pet.data.PetSkillTemplateInfo;   import pet.data.PetTemplateInfo;      public class AwakenEquipInfo   {                   private var _itemID:int;            private var _belongPet:String;            private var _belongPetId:int = -1;            private var _skillId1:int;            private var _skillId2:int;            public function AwakenEquipInfo() { super(); }
            public function get itemID() : int { return 0; }
            public function set itemID(value:int) : void { }
            public function get belongPetName() : String { return null; }
            public function get belongPetId() : int { return 0; }
            public function set belongPetId(value:int) : void { }
            public function set skillId1(id:int) : void { }
            public function get skillId1() : int { return 0; }
            public function set skillId2(id:int) : void { }
            public function get skillId2() : int { return 0; }
            public function getSkill1Info() : PetSkillTemplateInfo { return null; }
            public function getSkill2Info() : PetSkillTemplateInfo { return null; }
            private function getSkillInfo(skillId:int) : PetSkillTemplateInfo { return null; }
   }}