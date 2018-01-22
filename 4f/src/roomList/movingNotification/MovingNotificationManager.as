package roomList.movingNotification
{
   import ddt.data.analyze.MovingNotificationAnalyzer;
   import flash.display.DisplayObjectContainer;
   
   public class MovingNotificationManager
   {
      
      private static var _instance:MovingNotificationManager;
       
      
      private var _list:Array;
      
      private var _view:MovingNotificationView;
      
      public function MovingNotificationManager(){super();}
      
      public static function get Instance() : MovingNotificationManager{return null;}
      
      public function setup(param1:MovingNotificationAnalyzer) : void{}
      
      public function showIn(param1:DisplayObjectContainer) : void{}
      
      public function get view() : MovingNotificationView{return null;}
      
      public function hide() : void{}
   }
}
