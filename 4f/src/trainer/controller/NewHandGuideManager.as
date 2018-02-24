package trainer.controller
{
   public class NewHandGuideManager
   {
      
      private static const CUSTOM_PROGRESS:int = 0;
      
      private static var _instance:NewHandGuideManager;
       
      
      private var _progress:int;
      
      private var _mapID:int;
      
      public function NewHandGuideManager(param1:NewHandGuideManagerEnforcer){super();}
      
      public static function get Instance() : NewHandGuideManager{return null;}
      
      public function get progress() : int{return 0;}
      
      public function set progress(param1:int) : void{}
      
      public function get mapID() : int{return 0;}
      
      public function set mapID(param1:int) : void{}
      
      private function initData() : void{}
      
      public function hasShowEnergyMsg() : Boolean{return false;}
      
      public function isNewHandFB() : Boolean{return false;}
   }
}

class NewHandGuideManagerEnforcer
{
    
   
   function NewHandGuideManagerEnforcer(){super();}
}
