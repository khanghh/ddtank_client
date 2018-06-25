package morn.core.managers{   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import morn.core.components.Box;   import morn.core.components.Dialog;   import morn.core.utils.ObjectUtils;      public class DialogManager extends Sprite   {                   private var _box:Box;            private var _mask:Box;            private var _maskBg:Sprite;            public function DialogManager() { super(); }
            private function onAddedToStage(e:Event) : void { }
            private function onResize(e:Event) : void { }
            public function show(dialog:Dialog, closeOther:Boolean = false) : void { }
            public function popup(dialog:Dialog, closeOther:Boolean = false) : void { }
            public function close(dialog:Dialog) : void { }
            public function closeAll() : void { }
   }}