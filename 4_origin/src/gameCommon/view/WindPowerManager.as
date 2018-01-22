package gameCommon.view
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import gameCommon.model.WindPowerImgData;
   import road7th.comm.PackageIn;
   
   public class WindPowerManager
   {
      
      private static var _instance:WindPowerManager;
       
      
      private var _windPicMode:WindPowerImgData;
      
      public function WindPowerManager()
      {
         super();
      }
      
      public static function get Instance() : WindPowerManager
      {
         if(_instance == null)
         {
            _instance = new WindPowerManager();
         }
         return _instance;
      }
      
      public function init() : void
      {
         _windPicMode = new WindPowerImgData();
         SocketManager.Instance.addEventListener("windPic",_windPicCome);
      }
      
      private function _windPicCome(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         var _loc4_:ByteArray = _loc3_.readByteArray();
         _windPicMode.refeshData(_loc4_,_loc2_);
      }
      
      public function getWindPic(param1:Array) : BitmapData
      {
         return _windPicMode.getImgBmp(param1);
      }
      
      public function getWindPicById(param1:int) : BitmapData
      {
         return _windPicMode.getImgBmpById(param1);
      }
   }
}
