package starlingui.core.components{   import flash.display.BitmapData;   import flash.geom.Rectangle;   import flash.ui.Mouse;   import starling.display.DisplayObjectContainer;   import starling.display.Image;   import starling.display.Sprite;   import starling.events.Touch;   import starling.events.TouchEvent;   import starling.text.TextField;   import starling.textures.Texture;      [Event(name="triggered",type="starling.events.Event")]   public class PixelButton extends DisplayObjectContainer   {            private static const MAX_DRAG_DIST:Number = 50;                   private var mUpState:Texture;            private var mDownState:Texture;            private var mOverState:Texture;            private var mDisabledState:Texture;            private var mContents:Sprite;            private var mBody:Image;            private var mTextField:TextField;            private var mTextBounds:Rectangle;            private var mOverlay:Sprite;            private var mScaleWhenDown:Number;            private var mScaleWhenOver:Number;            private var mAlphaWhenDown:Number;            private var mAlphaWhenDisabled:Number;            private var mUseHandCursor:Boolean;            private var mEnabled:Boolean;            private var mState:String;            private var mTriggerBounds:Rectangle;            public function PixelButton(upState:Texture, text:String = "", downState:Texture = null, overState:Texture = null, disabledState:Texture = null, bitmapData:BitmapData = null) { super(); }
            override public function dispose() : void { }
            public function readjustSize(resetTextBounds:Boolean = true) : void { }
            private function createTextField() : void { }
            private function onTouch(event:TouchEvent) : void { }
            public function get state() : String { return null; }
            public function set state(value:String) : void { }
            private function setStateTexture(texture:Texture) : void { }
            public function get scaleWhenDown() : Number { return 0; }
            public function set scaleWhenDown(value:Number) : void { }
            public function get scaleWhenOver() : Number { return 0; }
            public function set scaleWhenOver(value:Number) : void { }
            public function get alphaWhenDown() : Number { return 0; }
            public function set alphaWhenDown(value:Number) : void { }
            public function get alphaWhenDisabled() : Number { return 0; }
            public function set alphaWhenDisabled(value:Number) : void { }
            public function get enabled() : Boolean { return false; }
            public function set enabled(value:Boolean) : void { }
            public function get text() : String { return null; }
            public function set text(value:String) : void { }
            public function get fontName() : String { return null; }
            public function set fontName(value:String) : void { }
            public function get fontSize() : Number { return 0; }
            public function set fontSize(value:Number) : void { }
            public function get fontColor() : uint { return null; }
            public function set fontColor(value:uint) : void { }
            public function get fontBold() : Boolean { return false; }
            public function set fontBold(value:Boolean) : void { }
            public function get upState() : Texture { return null; }
            public function set upState(value:Texture) : void { }
            public function get downState() : Texture { return null; }
            public function set downState(value:Texture) : void { }
            public function get overState() : Texture { return null; }
            public function set overState(value:Texture) : void { }
            public function get disabledState() : Texture { return null; }
            public function set disabledState(value:Texture) : void { }
            public function get textVAlign() : String { return null; }
            public function set textVAlign(value:String) : void { }
            public function get textHAlign() : String { return null; }
            public function set textHAlign(value:String) : void { }
            public function get textBounds() : Rectangle { return null; }
            public function set textBounds(value:Rectangle) : void { }
            public function get color() : uint { return null; }
            public function set color(value:uint) : void { }
            public function get overlay() : Sprite { return null; }
            override public function get useHandCursor() : Boolean { return false; }
            override public function set useHandCursor(value:Boolean) : void { }
   }}