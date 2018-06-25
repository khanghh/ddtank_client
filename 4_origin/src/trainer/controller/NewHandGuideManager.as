package trainer.controller
{
   public class NewHandGuideManager
   {
      
      private static const CUSTOM_PROGRESS:int = 0;
      
      private static var _instance:NewHandGuideManager;
       
      
      private var _progress:int;
      
      private var _mapID:int;
      
      public function NewHandGuideManager(enforcer:NewHandGuideManagerEnforcer)
      {
         super();
         initData();
      }
      
      public static function get Instance() : NewHandGuideManager
      {
         if(!_instance)
         {
            _instance = new NewHandGuideManager(new NewHandGuideManagerEnforcer());
         }
         return _instance;
      }
      
      public function get progress() : int
      {
         return _progress;
      }
      
      public function set progress(step:int) : void
      {
         if(step <= _progress)
         {
            return;
         }
         _progress = step;
      }
      
      public function get mapID() : int
      {
         return _mapID;
      }
      
      public function set mapID(value:int) : void
      {
         _mapID = value;
      }
      
      private function initData() : void
      {
      }
      
      public function hasShowEnergyMsg() : Boolean
      {
         return mapID != 111;
      }
      
      public function isNewHandFB() : Boolean
      {
         if(mapID == 111 || mapID == 112 || mapID == 113 || mapID == 114 || mapID == 115 || mapID == 116)
         {
            return true;
         }
         return false;
      }
   }
}

class NewHandGuideManagerEnforcer
{
    
   
   function NewHandGuideManagerEnforcer()
   {
      super();
   }
}
