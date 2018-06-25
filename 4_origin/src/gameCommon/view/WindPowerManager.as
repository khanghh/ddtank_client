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
      
      private function _windPicCome(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var bmpID:int = pkg.readByte();
         var bmpBytData:ByteArray = pkg.readByteArray();
         _windPicMode.refeshData(bmpBytData,bmpID);
      }
      
      public function getWindPic(arr:Array) : BitmapData
      {
         return _windPicMode.getImgBmp(arr);
      }
      
      public function getWindPicById(id:int) : BitmapData
      {
         return _windPicMode.getImgBmpById(id);
      }
   }
}
