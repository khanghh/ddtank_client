package treasure.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.ui.Mouse;   import treasure.controller.TreasureManager;   import treasure.events.TreasureEvents;   import treasure.model.TreasureModel;      public class TreasureCell extends Sprite implements Disposeable   {                   public var cell:TreasureFieldCell;            private var _field:MovieClip;            private var _tbxCount:FilterFrameText;            public var cartoon:MovieClip;            public var _fieldPos:int;            private var cartoon_dig:MovieClip;            private var cursor:Bitmap;            public function TreasureCell(fieldPos:int, dis:Boolean = true) { super(); }
            public function creatCartoon(frame:String = "show") : void { }
            private function __allOverHandler(e:Event) : void { }
            public function removeCell() : void { }
            public function digBackHandler() : void { }
            private function cartoon_digHandler(e:Event) : void { }
            private function removeEvent() : void { }
            public function addEvent() : void { }
            private function overHandler(e:MouseEvent) : void { }
            private function outHandler(e:MouseEvent) : void { }
            private function mouseMoveHandler(event:MouseEvent) : void { }
            private function clickHandler(e:MouseEvent) : void { }
            public function dispose() : void { }
   }}