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
      
      public function Button(param1:Texture, param2:String = "", param3:Texture = null, param4:Texture = null, param5:Texture = null)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("Texture \'upState\' cannot be null");
         }
         mUpState = param1;
         mDownState = param3;
         mOverState = param4;
         mDisabledState = param5;
         mState = "up";
         mBody = new Image(param1);
         mScaleWhenDown = !!param3?1:0.9;
         mAlphaWhenDown = 1;
         mScaleWhenOver = 1;
         mAlphaWhenDisabled = !!param5?1:0.5;
         mEnabled = true;
         mUseHandCursor = true;
         mTextBounds = new Rectangle(0,0,mBody.width,mBody.height);
         mContents = new Sprite();
         mContents.addChild(mBody);
         addChild(mContents);
         addEventListener("touch",onTouch);
         this.touchGroup = true;
         this.text = param2;
      }
      
      override public function dispose() : void
      {
         if(mTextField)
         {
            mTextField.dispose();
         }
         super.dispose();
      }
      
      public function readjustSize(param1:Boolean = true) : void
      {
         mBody.readjustSize();
         if(param1 && mTextField != null)
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
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc3_:Boolean = false;
         Mouse.cursor = mUseHandCursor && mEnabled && param1.interactsWith(this)?"button":"auto";
         var _loc2_:Touch = param1.getTouch(this);
         if(!mEnabled)
         {
            return;
         }
         if(_loc2_ == null)
         {
            state = "up";
         }
         else if(_loc2_.phase == "hover")
         {
            state = "over";
         }
         else if(_loc2_.phase == "began" && mState != "down")
         {
            mTriggerBounds = getBounds(stage,mTriggerBounds);
            mTriggerBounds.inflate(50,50);
            state = "down";
         }
         else if(_loc2_.phase == "moved")
         {
            _loc3_ = mTriggerBounds.contains(_loc2_.globalX,_loc2_.globalY);
            if(mState == "down" && !_loc3_)
            {
               state = "up";
            }
            else if(mState == "up" && _loc3_)
            {
               state = "down";
            }
         }
         else if(_loc2_.phase == "ended" && mState == "down")
         {
            state = "up";
            if(!_loc2_.cancelled)
            {
               dispatchEventWith("triggered",true);
            }
         }
      }
      
      public function get state() : String
      {
         return mState;
      }
      
      public function set state(param1:String) : void
      {
         mState = param1;
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
      
      private function setStateTexture(param1:Texture) : void
      {
         mBody.texture = !!param1?param1:mUpState;
      }
      
      public function get scaleWhenDown() : Number
      {
         return mScaleWhenDown;
      }
      
      public function set scaleWhenDown(param1:Number) : void
      {
         mScaleWhenDown = param1;
      }
      
      public function get scaleWhenOver() : Number
      {
         return mScaleWhenOver;
      }
      
      public function set scaleWhenOver(param1:Number) : void
      {
         mScaleWhenOver = param1;
      }
      
      public function get alphaWhenDown() : Number
      {
         return mAlphaWhenDown;
      }
      
      public function set alphaWhenDown(param1:Number) : void
      {
         mAlphaWhenDown = param1;
      }
      
      public function get alphaWhenDisabled() : Number
      {
         return mAlphaWhenDisabled;
      }
      
      public function set alphaWhenDisabled(param1:Number) : void
      {
         mAlphaWhenDisabled = param1;
      }
      
      public function get enabled() : Boolean
      {
         return mEnabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(mEnabled != param1)
         {
            mEnabled = param1;
            state = !!param1?"up":"disabled";
         }
      }
      
      public function get text() : String
      {
         return !!mTextField?mTextField.text:"";
      }
      
      public function set text(param1:String) : void
      {
         if(param1.length == 0)
         {
            if(mTextField)
            {
               mTextField.text = param1;
               mTextField.removeFromParent();
            }
         }
         else
         {
            createTextField();
            mTextField.text = param1;
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
      
      public function set fontName(param1:String) : void
      {
         createTextField();
         mTextField.fontName = param1;
      }
      
      public function get fontSize() : Number
      {
         return !!mTextField?mTextField.fontSize:12;
      }
      
      public function set fontSize(param1:Number) : void
      {
         createTextField();
         mTextField.fontSize = param1;
      }
      
      public function get fontColor() : uint
      {
         return !!mTextField?mTextField.color:0;
      }
      
      public function set fontColor(param1:uint) : void
      {
         createTextField();
         mTextField.color = param1;
      }
      
      public function get fontBold() : Boolean
      {
         return !!mTextField?mTextField.bold:false;
      }
      
      public function set fontBold(param1:Boolean) : void
      {
         createTextField();
         mTextField.bold = param1;
      }
      
      public function get upState() : Texture
      {
         return mUpState;
      }
      
      public function set upState(param1:Texture) : void
      {
         if(param1 == null)
         {
            throw new ArgumentError("Texture \'upState\' cannot be null");
         }
         if(mUpState != param1)
         {
            mUpState = param1;
            if(mState == "up" || mState == "disabled" && mDisabledState == null || mState == "down" && mDownState == null || mState == "over" && mOverState == null)
            {
               setStateTexture(param1);
            }
         }
      }
      
      public function get downState() : Texture
      {
         return mDownState;
      }
      
      public function set downState(param1:Texture) : void
      {
         if(mDownState != param1)
         {
            mDownState = param1;
            if(mState == "down")
            {
               setStateTexture(param1);
            }
         }
      }
      
      public function get overState() : Texture
      {
         return mOverState;
      }
      
      public function set overState(param1:Texture) : void
      {
         if(mOverState != param1)
         {
            mOverState = param1;
            if(mState == "over")
            {
               setStateTexture(param1);
            }
         }
      }
      
      public function get disabledState() : Texture
      {
         return mDisabledState;
      }
      
      public function set disabledState(param1:Texture) : void
      {
         if(mDisabledState != param1)
         {
            mDisabledState = param1;
            if(mState == "disabled")
            {
               setStateTexture(param1);
            }
         }
      }
      
      public function get textVAlign() : String
      {
         return !!mTextField?mTextField.vAlign:"center";
      }
      
      public function set textVAlign(param1:String) : void
      {
         createTextField();
         mTextField.vAlign = param1;
      }
      
      public function get textHAlign() : String
      {
         return !!mTextField?mTextField.hAlign:"center";
      }
      
      public function set textHAlign(param1:String) : void
      {
         createTextField();
         mTextField.hAlign = param1;
      }
      
      public function get textBounds() : Rectangle
      {
         return mTextBounds.clone();
      }
      
      public function set textBounds(param1:Rectangle) : void
      {
         mTextBounds = param1.clone();
         createTextField();
      }
      
      public function get color() : uint
      {
         return mBody.color;
      }
      
      public function set color(param1:uint) : void
      {
         mBody.color = param1;
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
      
      override public function set useHandCursor(param1:Boolean) : void
      {
         mUseHandCursor = param1;
      }
   }
}
