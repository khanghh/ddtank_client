package calendar.view
{
   import activeEvents.data.ActiveEventsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ActivityContentHolder extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _contentArea:TextArea;
      
      public function ActivityContentHolder()
      {
         super();
         configUI();
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityContentBg");
         addChild(_back);
      }
      
      override public function get height() : Number
      {
         return _back.height;
      }
      
      public function setContent(param1:ActiveEventsInfo) : void
      {
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_contentArea);
         _contentArea = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
