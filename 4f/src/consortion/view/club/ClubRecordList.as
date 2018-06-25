package consortion.view.club{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;      public class ClubRecordList extends Sprite implements Disposeable   {            public static const INVITE:int = 1;            public static const APPLY:int = 2;                   private var _items:Vector.<ClubRecordItem>;            private var _panel:ScrollPanel;            private var _vbox:VBox;            private var _data;            public function ClubRecordList() { super(); }
            private function init() : void { }
            public function setData(data:Object, type:int) : void { }
            private function clearItem() : void { }
            public function dispose() : void { }
   }}