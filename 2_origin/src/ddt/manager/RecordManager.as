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
      
      public function RecordManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : RecordManager
      {
         if(_instance == null)
         {
            _instance = new RecordManager();
         }
         return _instance;
      }
      
      public function addRecordIcon(hallView:HallStateView) : void
      {
         if(PathManager.getRecordPath() == "true" && _recordBtn == null)
         {
            _recordBtn = ComponentFactory.Instance.creatComponentByStylename("hall.record.playIcon");
            _recordBtn.addEventListener("click",__onRecordClick);
            hallView.addChild(_recordBtn);
         }
      }
      
      public function resetRecordPos(hallView:HallStateView) : void
      {
         if(_recordBtn != null)
         {
         }
      }
      
      protected function __onRecordClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      public function deleteIcon() : void
      {
         if(_recordBtn != null)
         {
            _recordBtn.removeEventListener("click",__onRecordClick);
            ObjectUtils.disposeObject(_recordBtn);
            _recordBtn = null;
         }
      }
   }
}
