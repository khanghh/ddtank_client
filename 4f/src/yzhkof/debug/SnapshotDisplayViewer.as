package yzhkof.debug{   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import yzhkof.ToolBitmapData;      public class SnapshotDisplayViewer extends Sprite   {                   private var bitmap:Bitmap;            private var bitmapdata:BitmapData;            private var source:DisplayObject;            public function SnapshotDisplayViewer() { super(); }
            public function clearView() : void { }
            public function view(dobj:DisplayObject) : void { }
            private function onEnterFrame(e:Event) : void { }
   }}