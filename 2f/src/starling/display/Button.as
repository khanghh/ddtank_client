package starling.display
{
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   [Event(name="triggered",type="starling.events.Event")]
   public class Button extends DisplayObjectContainer
   {
      
      private static const MAX_DRAG_DIST:Number = 50;
       
      
      private var mUpState:Texture;
      
      private var mDownState:Texture;
      
      private var mOverState:Texture;
      
      private var mDisabledState:Texture;
      
      private var mContents:Sprite;
      
      private var mBody:Image;
      
      private var mTextField:TextField;
      
      private var mTextBounds:Rectangle;
      
      private var mOverlay:Sprite;
      
      private var mScaleWhenDown:Number;
      
      private var mScaleWhenOver:Number;
      
      private var mAlphaWhenDown:Number;
      
      private var mAlphaWhenDisabled:Number;
      
      private var mUseHandCursor:Boolean;
      
      private var mEnabled:Boolean;
      
      private var mState:String;
      
      private var mTriggerBounds:Rectangle;
      
      public function Button(param1:Texture, param2:String = "", param3:Texture = null, param4:Texture = null, param5:Texture = null){super();}
      
      override public function dispose() : void{}
      
      public function readjustSize(param1:Boolean = true) : void{}
      
      private function createTextField() : void{}
      
      private function onTouch(param1:TouchEvent) : void{}
      
      public function get state() : String{return null;}
      
      public function set state(param1:String) : void{}
      
      private function setStateTexture(param1:Texture) : void{}
      
      public function get scaleWhenDown() : Number{return 0;}
      
      public function set scaleWhenDown(param1:Number) : void{}
      
      public function get scaleWhenOver() : Number{return 0;}
      
      public function set scaleWhenOver(param1:Number) : void{}
      
      public function get alphaWhenDown() : Number{return 0;}
      
      public function set alphaWhenDown(param1:Number) : void{}
      
      public function get alphaWhenDisabled() : Number{return 0;}
      
      public function set alphaWhenDisabled(param1:Number) : void{}
      
      public function get enabled() : Boolean{return false;}
      
      public function set enabled(param1:Boolean) : void{}
      
      public function get text() : String{return null;}
      
      public function set text(param1:String) : void{}
      
      public function get fontName() : String{return null;}
      
      public function set fontName(param1:String) : void{}
      
      public function get fontSize() : Number{return 0;}
      
      public function set fontSize(param1:Number) : void{}
      
      public function get fontColor() : uint{return null;}
      
      public function set fontColor(param1:uint) : void{}
      
      public function get fontBold() : Boolean{return false;}
      
      public function set fontBold(param1:Boolean) : void{}
      
      public function get upState() : Texture{return null;}
      
      public function set upState(param1:Texture) : void{}
      
      public function get downState() : Texture{return null;}
      
      public function set downState(param1:Texture) : void{}
      
      public function get overState() : Texture{return null;}
      
      public function set overState(param1:Texture) : void{}
      
      public function get disabledState() : Texture{return null;}
      
      public function set disabledState(param1:Texture) : void{}
      
      public function get textVAlign() : String{return null;}
      
      public function set textVAlign(param1:String) : void{}
      
      public function get textHAlign() : String{return null;}
      
      public function set textHAlign(param1:String) : void{}
      
      public function get textBounds() : Rectangle{return null;}
      
      public function set textBounds(param1:Rectangle) : void{}
      
      public function get color() : uint{return null;}
      
      public function set color(param1:uint) : void{}
      
      public function get body() : Image{return null;}
      
      public function get overlay() : Sprite{return null;}
      
      override public function get useHandCursor() : Boolean{return false;}
      
      override public function set useHandCursor(param1:Boolean) : void{}
   }
}
