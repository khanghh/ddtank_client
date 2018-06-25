package yzhkof.debug{   import flash.events.Event;   import flash.events.MouseEvent;   import flash.net.FileFilter;   import flash.net.FileReference;   import flash.text.TextField;   import flash.text.TextFieldType;   import flash.text.TextFormat;   import flash.utils.getQualifiedClassName;   import yzhkof.ui.DragPanel;   import yzhkof.ui.TextPanel;   import yzhkof.ui.TileContainer;   import yzhkof.ui.event.ComponentEvent;   import yzhkof.util.StringUtil;      public class ScriptViewer extends DragPanel   {                   private var textField:TextField;            private var btn_container:TileContainer;            private var run_btn:TextPanel;            private var target_btn:TextPanel;            private var save_btn:TextPanel;            private var load_btn:TextPanel;            private var import_btn:TextPanel;            private var import_text:TextField;            private const textWidth:Number = 500;            private const textHeight:Number = 300;            private var importCount:uint = 0;            public function ScriptViewer() { super(); }
            public function setTarget(target:Object) : void { }
            private function init() : void { }
            private function __btnSizeChange(e:Event) : void { }
            private function __onSaveClick(e:Event) : void { }
            private function __onLoadClick(e:Event) : void { }
            private function __onImportClick(e:Event) : void { }
            private function getPackageName() : String { return null; }
            private function __onTargetClick(e:Event) : void { }
            private function __onRunBtnClick(e:Event) : void { }
   }}