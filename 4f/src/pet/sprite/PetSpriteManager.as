package pet.sprite
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   
   public class PetSpriteManager extends CoreManager
   {
      
      private static var _instance:PetSpriteManager;
      
      public static const SHOWPET_TIP:String = "showPetTip";
      
      public static const PET_INIT:String = "pet_init";
      
      public static const PET_SAY:String = "pet_say";
      
      public static const PET_SWITCHPETSPRITE:String = "pet_switchPetSprite";
      
      public static const PET_SHOWPETSPRITE:String = "pet_showPetSprite";
      
      public static const PET_HIDEPETSPRITE:String = "pet_hidePetSprite";
      
      public static const PET_UPDATE_DATA:String = "pet_update_data";
       
      
      public var hasBeenSetup:Boolean = false;
      
      public var pkgs:Array;
      
      public function PetSpriteManager(){super();}
      
      public static function get Instance() : PetSpriteManager{return null;}
      
      public function setup() : void{}
      
      protected function __onGradeChanged(param1:PlayerPropertyEvent) : void{}
      
      public function checkFarmCropRipe() : Boolean{return false;}
      
      private function checkFarmCrop() : Boolean{return false;}
      
      public function canInitPetSprite() : Boolean{return false;}
      
      public function switchPetSprite(param1:Boolean) : void{}
      
      public function showPetSprite(param1:Boolean = false, param2:Boolean = false) : void{}
      
      public function hidePetSprite(param1:Boolean = false, param2:Boolean = true) : void{}
      
      private function sendToControlEvent(param1:String, param2:Object = null) : void{}
   }
}
