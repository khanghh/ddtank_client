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
      
      public function Button(upState:Texture, text:String = "", downState:Texture = null, overState:Texture = null, disabledState:Texture = null)
      {
         super();
         if(upState == null)
         {
            throw new ArgumentError("Texture \'upState\' cannot be null");
         }
         mUpState = upState;
         mDownState = downState;
         mOverState = overState;
         mDisabledState = disabledState;
         mState = "up";
         mBody = new Image(upState);
         mScaleWhenDown = !!downState?1:0.9;
         mAlphaWhenDown = 1;
         mScaleWhenOver = 1;
         mAlphaWhenDisabled = !!disabledState?1:0.5;
         mEnabled = true;
         mUseHandCursor = true;
         mTextBounds = new Rectangle(0,0,mBody.width,mBody.height);
         mContents = new Sprite();
         mContents.addChild(mBody);
         addChild(mContents);
         addEventListener("touch",onTouch);
         this.touchGroup = true;
         this.text = text;
      }
      
      override public function dispose() : void
      {
         if(mTextField)
         {
            mTextField.dispose();
         }
         super.dispose();
      }
      
      public function readjustSize(resetTextBounds:Boolean = true) : void
      {
         mBody.readjustSize();
         if(resetTextBounds && mTextField != null)
         {
            textBounds = new Rectangle(0,0,mBody.width,mBody.height);
         }
      }
      
      private function createTextField() : void
      {
         if(mTextField == null)
         {
            mTextField = new TextField(mTextBounds.width,mTextBounds.height,"");
            mTextField.vAlign = "center";
            mTextField.hAlign = "center";
            mTextField.touchable = false;
            mTextField.autoScale = true;
            mTextField.batchable = true;
         }
         mTextField.width = mTextBounds.width;
         mTextField.height = mTextBounds.height;
         mTextField.x = mTextBounds.x;
         mTextField.y = mTextBounds.y;
      }
      
      private function onTouch(event:TouchEvent) : void
      {
         var isWithinBounds:Boolean = false;
         Mouse.cursor = mUseHandCursor && mEnabled && event.interactsWith(this)?"button":"auto";
         var touch:Touch = event.getTouch(this);
         if(!mEnabled)
         {
            return;
         }
         if(touch == null)
         {
            state = "up";
         }
         else if(touch.phase == "hover")
         {
            state = "over";
         }
         else if(touch.phase == "began" && mState != "down")
         {
            mTriggerBounds = getBounds(stage,mTriggerBounds);
            mTriggerBounds.inflate(50,50);
            state = "down";
         }
         else if(touch.phase == "moved")
         {
            isWithinBounds = mTriggerBounds.contains(touch.globalX,touch.globalY);
            if(mState == "down" && !isWithinBounds)
            {
               state = "up";
            }
            else if(mState == "up" && isWithinBounds)
            {
               state = "down";
            }
         }
         else if(touch.phase == "ended" && mState == "down")
         {
            state = "up";
            if(!touch.cancelled)
            {
               dispatchEventWith("triggered",true);
            }
         }
      }
      
      public function get state() : String
      {
         return mState;
      }
      
      public function set state(value:String) : void
      {
         mState = value;
         var _loc2_:* = 0;
         mContents.y = _loc2_;
         mContents.x = _loc2_;
         _loc2_ = 1;
         mContents.alpha = _loc2_;
         _loc2_ = _loc2_;
         mContents.scaleY = _loc2_;
         mContents.scaleX = _loc2_;
         _loc2_ = mState;
         if("down" !== _loc2_)
         {
            if("up" !== _loc2_)
            {
               if("over" !== _loc2_)
               {
                  if("disabled" !== _loc2_)
                  {
                     throw new ArgumentError("Invalid button state: " + mState);
                  }
                  setStateTexture(mDisabledState);
                  mContents.alpha = mAlphaWhenDisabled;
               }
               else
               {
                  setStateTexture(mOverState);
                  _loc2_ = mScaleWhenOver;
                  mContents.scaleY = _loc2_;
                  mContents.scaleX = _loc2_;
                  mContents.x = (1 - mScaleWhenOver) / 2 * mBody.width;
                  mContents.y = (1 - mScaleWhenOver) / 2 * mBody.height;
               }
            }
            else
            {
               setStateTexture(mUpState);
            }
         }
         else
         {
            setStateTexture(mDownState);
            mContents.alpha = mAlphaWhenDown;
            _loc2_ = mScaleWhenDown;
            mContents.scaleY = _loc2_;
            mContents.scaleX = _loc2_;
            mContents.x = (1 - mScaleWhenDown) / 2 * mBody.width;
            mContents.y = (1 - mScaleWhenDown) / 2 * mBody.height;
         }
      }
      
      private function setStateTexture(texture:Texture) : void
      {
         mBody.texture = !!texture?texture:mUpState;
      }
      
      public function get scaleWhenDown() : Number
      {
         return mScaleWhenDown;
      }
      
      public function set scaleWhenDown(value:Number) : void
      {
         mScaleWhenDown = value;
      }
      
      public function get scaleWhenOver() : Number
      {
         return mScaleWhenOver;
      }
      
      public function set scaleWhenOver(value:Number) : void
      {
         mScaleWhenOver = value;
      }
      
      public function get alphaWhenDown() : Number
      {
         return mAlphaWhenDown;
      }
      
      public function set alphaWhenDown(value:Number) : void
      {
         mAlphaWhenDown = value;
      }
      
      public function get alphaWhenDisabled() : Number
      {
         return mAlphaWhenDisabled;
      }
      
      public function set alphaWhenDisabled(value:Number) : void
      {
         mAlphaWhenDisabled = value;
      }
      
      public function get enabled() : Boolean
      {
         return mEnabled;
      }
      
      public function set enabled(value:Boolean) : void
      {
         if(mEnabled != value)
         {
            mEnabled = value;
            state = !!value?"up":"disabled";
         }
      }
      
      public function get text() : String
      {
         return !!mTextField?mTextField.text:"";
      }
      
      public function set text(value:String) : void
      {
         if(value.length == 0)
         {
            if(mTextField)
            {
               mTextField.text = value;
               mTextField.removeFromParent();
            }
         }
         else
         {
            createTextField();
            mTextField.text = value;
            if(mTextField.parent == null)
            {
               mContents.addChild(mTextField);
            }
         }
      }
      
      public function get fontName() : String
      {
         return !!mTextField?mTextField.fontName:"Verdana";
      }
      
      public function set fontName(value:String) : void
      {
         createTextField();
         mTextField.fontName = value;
      }
      
      public function get fontSize() : Number
      {
         return !!mTextField?mTextField.fontSize:12;
      }
      
      public function set fontSize(value:Number) : void
      {
         createTextField();
         mTextField.fontSize = value;
      }
      
      public function get fontColor() : uint
      {
         return !!mTextField?mTextField.color:0;
      }
      
      public function set fontColor(value:uint) : void
      {
         createTextField();
         mTextField.color = value;
      }
      
      public function get fontBold() : Boolean
      {
         return !!mTextField?mTextField.bold:false;
      }
      
      public function set fontBold(value:Boolean) : void
      {
         createTextField();
         mTextField.bold = value;
      }
      
      public function get upState() : Texture
      {
         return mUpState;
      }
      
      public function set upState(value:Texture) : void
      {
         if(value == null)
         {
            throw new ArgumentError("Texture \'upState\' cannot be null");
         }
         if(mUpState != value)
         {
            mUpState = value;
            if(mState == "up" || mState == "disabled" && mDisabledState == null || mState == "down" && mDownState == null || mState == "over" && mOverState == null)
            {
               setStateTexture(value);
            }
         }
      }
      
      public function get downState() : Texture
      {
         return mDownState;
      }
      
      public function set downState(value:Texture) : void
      {
         if(mDownState != value)
         {
            mDownState = value;
            if(mState == "down")
            {
               setStateTexture(value);
            }
         }
      }
      
      public function get overState() : Texture
      {
         return mOverState;
      }
      
      public function set overState(value:Texture) : void
      {
         if(mOverState != value)
         {
            mOverState = value;
            if(mState == "over")
            {
               setStateTexture(value);
            }
         }
      }
      
      public function get disabledState() : Texture
      {
         return mDisabledState;
      }
      
      public function set disabledState(value:Texture) : void
      {
         if(mDisabledState != value)
         {
            mDisabledState = value;
            if(mState == "disabled")
            {
               setStateTexture(value);
            }
         }
      }
      
      public function get textVAlign() : String
      {
         return !!mTextField?mTextField.vAlign:"center";
      }
      
      public function set textVAlign(value:String) : void
      {
         createTextField();
         mTextField.vAlign = value;
      }
      
      public function get textHAlign() : String
      {
         return !!mTextField?mTextField.hAlign:"center";
      }
      
      public function set textHAlign(value:String) : void
      {
         createTextField();
         mTextField.hAlign = value;
      }
      
      public function get textBounds() : Rectangle
      {
         return mTextBounds.clone();
      }
      
      public function set textBounds(value:Rectangle) : void
      {
         mTextBounds = value.clone();
         createTextField();
      }
      
      public function get color() : uint
      {
         return mBody.color;
      }
      
      public function set color(value:uint) : void
      {
         mBody.color = value;
      }
      
      public function get body() : Image
      {
         return mBody;
      }
      
      public function get overlay() : Sprite
      {
         if(mOverlay == null)
         {
            mOverlay = new Sprite();
         }
         mContents.addChild(mOverlay);
         return mOverlay;
      }
      
      override public function get useHandCursor() : Boolean
      {
         return mUseHandCursor;
      }
      
      override public function set useHandCursor(value:Boolean) : void
      {
         mUseHandCursor = value;
      }
   }
}
