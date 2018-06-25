package calendar.view{   import activeEvents.data.ActiveEventsInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class ActivityContentHolder extends Sprite implements Disposeable   {                   private var _back:DisplayObject;            private var _contentArea:TextArea;            public function ActivityContentHolder() { super(); }
            private function configUI() : void { }
            override public function get height() : Number { return 0; }
            public function setContent(info:ActiveEventsInfo) : void { }
            public function dispose() : void { }
   }}