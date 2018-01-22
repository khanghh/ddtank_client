package roomList.movingNotification
{
   import ddt.data.analyze.MovingNotificationAnalyzer;
   import flash.display.DisplayObjectContainer;
   
   public class MovingNotificationManager
   {
      
      private static var _instance:MovingNotificationManager;
       
      
      private var _list:Array;
      
      private var _view:MovingNotificationView;
      
      public function MovingNotificationManager()
      {
         super();
         _list = [];
      }
      
      public static function get Instance() : MovingNotificationManager
      {
         if(!_instance)
         {
            _instance = new MovingNotificationManager();
         }
         return _instance;
      }
      
      public function setup(param1:MovingNotificationAnalyzer) : void
      {
         _list = param1.list;
      }
      
      public function showIn(param1:DisplayObjectContainer) : void
      {
         if(!_view)
         {
            _view = new MovingNotificationView();
         }
         _view.list = _list;
         param1.addChild(_view);
      }
      
      public function get view() : MovingNotificationView
      {
         return _view;
      }
      
      public function hide() : void
      {
         if(_view)
         {
            _view.dispose();
         }
         _view = null;
      }
   }
}
