package gameCommon
{
   import ddt.data.BallInfo;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.BallManager;
   import ddt.manager.ItemManager;
   import flash.utils.Dictionary;
   import room.model.RoomPlayer;
   import room.model.WeaponInfo;
   
   public class LoadBombManager
   {
      
      public static const SpecialBomb:Array = [1,3,4];
      
      public static const SpecialAllBomb:Array = [1,3,4,64,59,97,98,120,10619];
      
      public static const SceneEffectBomb:Array = [107,130,147,149];
      
      public static const TwoBomb:Object = {
         11245:11241,
         112451:112411,
         112452:112412,
         11246:11242
      };
      
      private static var _instance:LoadBombManager;
       
      
      private var _tempWeaponInfos:Dictionary;
      
      private var _tempCraterIDs:Dictionary;
      
      public function LoadBombManager(){super();}
      
      public static function get Instance() : LoadBombManager{return null;}
      
      public function loadFullRoomPlayersBomb(param1:Array) : void{}
      
      private function loadFullWeaponBombMovie(param1:Array) : void{}
      
      private function loadFullWeaponBombBitMap(param1:Array) : void{}
      
      private function loadBomb(param1:WeaponInfo) : void{}
      
      public function getLoadBombComplete(param1:WeaponInfo) : Boolean{return false;}
      
      public function getUnloadedBombString(param1:WeaponInfo) : String{return null;}
      
      public function loadLivingBomb(param1:int) : void{}
      
      public function getLivingBombComplete(param1:int) : Boolean{return false;}
      
      public function loadSpecialBomb() : void{}
      
      public function loadSceneEffectBomb() : void{}
      
      public function getUnloadedSpecialBombString() : String{return null;}
      
      public function getLoadSpecialBombComplete() : Boolean{return false;}
      
      public function loadOutBomb(param1:Array) : void{}
      
      private function hasLoadWeaponBomb(param1:int) : Boolean{return false;}
      
      public function loadFullRoomPlayersBomb3D(param1:Array) : void{}
      
      private function loadFullWeaponBombMovie3D(param1:Array) : void{}
      
      public function loadLivingBomb3D(param1:int) : void{}
      
      public function getLivingBombComplete3D(param1:int) : Boolean{return false;}
      
      public function loadSpecialBomb3D() : void{}
      
      public function loadOutBomb3D(param1:Array) : void{}
      
      public function loadSceneEffectBomb3D() : void{}
      
      public function getLoadBombComplete3D(param1:WeaponInfo) : Boolean{return false;}
      
      public function getLoadSpecialBombComplete3D() : Boolean{return false;}
      
      public function getUnloadedSpecialBomb3DString() : String{return null;}
      
      public function getLoadSceneEffectBombComplete3D() : Boolean{return false;}
   }
}
