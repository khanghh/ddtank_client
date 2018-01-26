package ddt.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import hall.HallStateView;
   
   public class RecordManager extends EventDispatcher
   {
      
      private static var _instance:RecordManager;
       
      
      private var _recordBtn:BaseButton;
      
      public function RecordManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : RecordManager{return null;}
      
      public function addRecordIcon(param1:HallStateView) : void{}
      
      public function resetRecordPos(param1:HallStateView) : void{}
      
      protected function __onRecordClick(param1:MouseEvent) : void{}
      
      public function deleteIcon() : void{}
   }
}
