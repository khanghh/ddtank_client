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
      
      public function WindPowerManager(){super();}
      
      public static function get Instance() : WindPowerManager{return null;}
      
      public function init() : void{}
      
      private function _windPicCome(param1:CrazyTankSocketEvent) : void{}
      
      public function getWindPic(param1:Array) : BitmapData{return null;}
      
      public function getWindPicById(param1:int) : BitmapData{return null;}
   }
}
