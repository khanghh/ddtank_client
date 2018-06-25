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
      
      public function PetSpriteManager()
      {
         pkgs = [];
         super();
      }
      
      public static function get Instance() : PetSpriteManager
      {
         if(!_instance)
         {
            _instance = new PetSpriteManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
      }
      
      protected function __onGradeChanged(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"])
         {
            if(canInitPetSprite())
            {
               setup();
            }
         }
      }
      
      public function checkFarmCropRipe() : Boolean
      {
         return checkFarmCrop();
      }
      
      private function checkFarmCrop() : Boolean
      {
         var hasCropMature:Boolean = false;
         var crops:Vector.<FieldVO> = FarmModelController.instance.model.selfFieldsInfo;
         if(crops == null)
         {
            return false;
         }
         var _loc5_:int = 0;
         var _loc4_:* = crops;
         for each(var crop in crops)
         {
            if(crop.plantGrownPhase == 2)
            {
               hasCropMature = true;
               break;
            }
         }
         return hasCropMature;
      }
      
      public function canInitPetSprite() : Boolean
      {
         return PlayerManager.Instance.Self.Grade >= ServerConfigManager.instance.minOpenPetSystemLevel;
      }
      
      public function switchPetSprite(val:Boolean) : void
      {
         sendToControlEvent("pet_switchPetSprite",[val]);
      }
      
      public function showPetSprite(immediately:Boolean = false, showAlways:Boolean = false) : void
      {
         sendToControlEvent("pet_showPetSprite",[immediately,showAlways]);
      }
      
      public function hidePetSprite(immediately:Boolean = false, canShowNext:Boolean = true) : void
      {
         sendToControlEvent("pet_hidePetSprite",[immediately,canShowNext]);
      }
      
      private function sendToControlEvent(eventType:String, data:Object = null) : void
      {
         if(!hasBeenSetup)
         {
            return;
         }
         var event:CEvent = new CEvent(eventType,data);
         pkgs.push(event);
         dispatchEvent(new CEvent("pet_update_data"));
      }
   }
}
