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
      
      protected function __onGradeChanged(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
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
         var _loc2_:Boolean = false;
         var _loc1_:Vector.<FieldVO> = FarmModelController.instance.model.selfFieldsInfo;
         if(_loc1_ == null)
         {
            return false;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc3_ in _loc1_)
         {
            if(_loc3_.plantGrownPhase == 2)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      public function canInitPetSprite() : Boolean
      {
         return PlayerManager.Instance.Self.Grade >= ServerConfigManager.instance.minOpenPetSystemLevel;
      }
      
      public function switchPetSprite(param1:Boolean) : void
      {
         sendToControlEvent("pet_switchPetSprite",[param1]);
      }
      
      public function showPetSprite(param1:Boolean = false, param2:Boolean = false) : void
      {
         sendToControlEvent("pet_showPetSprite",[param1,param2]);
      }
      
      public function hidePetSprite(param1:Boolean = false, param2:Boolean = true) : void
      {
         sendToControlEvent("pet_hidePetSprite",[param1,param2]);
      }
      
      private function sendToControlEvent(param1:String, param2:Object = null) : void
      {
         if(!hasBeenSetup)
         {
            return;
         }
         var _loc3_:CEvent = new CEvent(param1,param2);
         pkgs.push(_loc3_);
         dispatchEvent(new CEvent("pet_update_data"));
      }
   }
}
