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
      
      public function setup(analyzer:MovingNotificationAnalyzer) : void
      {
         _list = analyzer.list;
      }
      
      public function showIn(display:DisplayObjectContainer) : void
      {
         if(!_view)
         {
            _view = new MovingNotificationView();
         }
         _view.list = _list;
         display.addChild(_view);
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
