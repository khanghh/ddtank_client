package character
{
   import character.action.ActionSet;
   import character.action.BaseAction;
   import character.action.ComplexBitmapAction;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import mx.events.PropertyChangeEvent;
   
   public class ComplexBitmapCharacter extends ComplexItem implements ICharacter
   {
       
      
      protected var _assets:Dictionary;
      
      protected var _actionSet:ActionSet;
      
      protected var _currentAction:ComplexBitmapAction;
      
      protected var _label:String = "";
      
      protected var _autoStop:Boolean;
      
      protected var _bitmapRendItems:Vector.<FrameByFrameItem>;
      
      private var _registerPoint:Point;
      
      private var _rect:Rectangle;
      
      protected var _soundEnabled:Boolean = false;
      
      public function ComplexBitmapCharacter(param1:Dictionary, param2:XML = null, param3:String = "", param4:Number = 0, param5:Number = 0, param6:String = "original", param7:Boolean = false)
      {
         this._registerPoint = new Point(0,0);
         this._bitmapRendItems = new Vector.<FrameByFrameItem>();
         this._assets = param1;
         this._actionSet = new ActionSet();
         if(param2)
         {
            param4 = int(param2.@width);
            param5 = int(param2.@height);
         }
         this._autoStop = param7;
         super(param4,param5,param6,"auto",true);
         _type = CharacterType.COMPLEX_BITMAP_TYPE;
         if(param2)
         {
            this.description = param2;
         }
         this._label = param3;
      }
      
      public function get soundEnabled() : Boolean
      {
         return this._soundEnabled;
      }
      
      private function set _164832462soundEnabled(param1:Boolean) : void
      {
         if(this._soundEnabled == param1)
         {
            return;
         }
         this._soundEnabled = param1;
      }
      
      public function set description(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:XMLList = null;
         var _loc7_:Vector.<FrameByFrameItem> = null;
         var _loc8_:int = 0;
         var _loc9_:ComplexBitmapAction = null;
         var _loc10_:XML = null;
         var _loc11_:BitmapRendItem = null;
         this._actionSet = new ActionSet();
         var _loc2_:XMLList = param1..action;
         this._label = param1.@label;
         if(param1.hasOwnProperty("@registerX"))
         {
            this._registerPoint.x = param1.@registerX;
         }
         if(param1.hasOwnProperty("@registerY"))
         {
            this._registerPoint.y = param1.@registerY;
         }
         if(param1.hasOwnProperty("@rect"))
         {
            _loc4_ = String(param1.@rect);
            this._rect = new Rectangle();
            _loc5_ = _loc4_.split("|");
            this._rect.x = _loc5_[0];
            this._rect.y = _loc5_[1];
            this._rect.width = _loc5_[2];
            this._rect.height = _loc5_[3];
         }
         for each(_loc3_ in _loc2_)
         {
            _loc6_ = _loc3_.asset;
            _loc7_ = new Vector.<FrameByFrameItem>();
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length())
            {
               _loc10_ = _loc6_[_loc8_];
               _loc11_ = _loc10_.@frames == ""?new FrameByFrameItem(_loc10_.@width,_loc10_.@height,this._assets[String(_loc10_.@resource)]):new CrossFrameItem(_loc10_.@width,_loc10_.@height,this._assets[String(_loc10_.@resource)],CharacterUtils.creatFrames(_loc10_.@frames));
               FrameByFrameItem(_loc11_).sourceName = String(_loc10_.@resource);
               _loc11_.name = _loc10_.@name;
               if(_loc10_.hasOwnProperty("@x"))
               {
                  _loc11_.x = _loc10_.@x;
               }
               if(_loc10_.hasOwnProperty("@y"))
               {
                  _loc11_.y = _loc10_.@y;
               }
               if(_loc10_.hasOwnProperty("@points"))
               {
                  FrameByFrameItem(_loc11_).moveInfo = CharacterUtils.creatPoints(_loc10_.@points);
               }
               _loc7_.push(_loc11_);
               this._bitmapRendItems.push(_loc11_);
               _loc8_++;
            }
            _loc9_ = new ComplexBitmapAction(_loc7_,_loc3_.@name,_loc3_.@next,int(_loc3_.@priority));
            _loc9_.sound = _loc3_.@sound;
            _loc9_.endStop = String(_loc3_.@endStop) == "true";
            _loc9_.sound = String(_loc3_.@sound);
            this._actionSet.addAction(_loc9_);
         }
         if(this._actionSet.actions.length > 0)
         {
            this.currentAction = this._actionSet.currentAction as ComplexBitmapAction;
         }
      }
      
      public function getActionFrames(param1:String) : int
      {
         var _loc2_:BaseAction = this._actionSet.getAction(param1);
         if(_loc2_)
         {
            return _loc2_.len;
         }
         return 0;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      private function set _102727412label(param1:String) : void
      {
         this._label = param1;
      }
      
      public function hasAction(param1:String) : Boolean
      {
         return this._actionSet.getAction(param1) != null;
      }
      
      private function set _1408207997assets(param1:Dictionary) : void
      {
         this._assets = param1;
      }
      
      public function get assets() : Dictionary
      {
         return this._assets;
      }
      
      public function get actions() : Array
      {
         return this._actionSet.actions;
      }
      
      public function addAction(param1:BaseAction) : void
      {
         if(param1 is ComplexBitmapAction)
         {
            this._actionSet.addAction(param1);
            if(this._currentAction == null)
            {
               this.currentAction = param1 as ComplexBitmapAction;
            }
            dispatchEvent(new CharacterEvent(CharacterEvent.ADD_ACTION,param1));
            return;
         }
         throw new Error("ComplexBitmapCharacter\'s action must be ComplexBitmapAction");
      }
      
      public function doAction(param1:String) : void
      {
         var _loc3_:FrameByFrameItem = null;
         play();
         var _loc2_:ComplexBitmapAction = this._actionSet.getAction(param1) as ComplexBitmapAction;
         if(_loc2_)
         {
            if(this._currentAction == null)
            {
               this.currentAction = _loc2_;
            }
            else if(_loc2_.priority >= this._currentAction.priority)
            {
               for each(_loc3_ in this._currentAction.assets)
               {
                  _loc3_.stop();
                  removeItem(_loc3_);
               }
               this._currentAction.reset();
               this.currentAction = _loc2_;
            }
         }
      }
      
      protected function set currentAction(param1:ComplexBitmapAction) : void
      {
         var _loc2_:FrameByFrameItem = null;
         param1.reset();
         this._currentAction = param1;
         this._autoStop = this._currentAction.endStop;
         for each(_loc2_ in this._currentAction.assets)
         {
            _loc2_.reset();
            _loc2_.play();
            addItem(_loc2_);
         }
         if(this._currentAction.sound != "" && this._soundEnabled)
         {
            CharacterSoundManager.instance.play(this._currentAction.sound);
         }
      }
      
      override protected function update() : void
      {
         super.update();
         if(this._currentAction == null)
         {
            return;
         }
         this._currentAction.update();
         if(this._currentAction.isEnd)
         {
            if(this._autoStop)
            {
               stop();
            }
            else
            {
               this.doAction(this._currentAction.nextAction);
            }
         }
      }
      
      public function get registerPoint() : Point
      {
         return this._registerPoint;
      }
      
      public function get rect() : Rectangle
      {
         if(this._rect == null)
         {
            this._rect = new Rectangle(0,0,_itemWidth,_itemHeight);
         }
         return this._rect;
      }
      
      override public function toXml() : XML
      {
         var _loc1_:XML = <character></character>;
         _loc1_.@type = _type;
         _loc1_.@width = _itemWidth;
         _loc1_.@height = _itemHeight;
         _loc1_.@label = this._label;
         _loc1_.@registerX = this._registerPoint.x;
         _loc1_.@registerY = this._registerPoint.y;
         _loc1_.@rect = [this.rect.x,this.rect.y,this.rect.width,this.rect.height].join("|");
         _loc1_.appendChild(this._actionSet.toXml());
         return _loc1_;
      }
      
      public function removeAction(param1:String) : void
      {
         var _loc3_:FrameByFrameItem = null;
         var _loc2_:BaseAction = this._actionSet.getAction(param1);
         if(_loc2_ && this._currentAction == _loc2_)
         {
            for each(_loc3_ in this._currentAction.assets)
            {
               _loc3_.stop();
               removeItem(_loc3_);
            }
            this._currentAction = null;
         }
         this._actionSet.removeAction(param1);
         dispatchEvent(new CharacterEvent(CharacterEvent.REMOVE_ACTION));
      }
      
      override public function dispose() : void
      {
         var _loc1_:FrameByFrameItem = null;
         super.dispose();
         for each(_loc1_ in this._bitmapRendItems)
         {
            _loc1_.dispose();
         }
         this._bitmapRendItems = null;
         this._assets = null;
         this._actionSet.dispose();
         this._actionSet = null;
         this._currentAction = null;
      }
      
      [Bindable(event="propertyChange")]
      public function set assets(param1:Dictionary) : void
      {
         var _loc2_:Object = this.assets;
         if(_loc2_ !== param1)
         {
            this._1408207997assets = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"assets",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set soundEnabled(param1:Boolean) : void
      {
         var _loc2_:Object = this.soundEnabled;
         if(_loc2_ !== param1)
         {
            this._164832462soundEnabled = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundEnabled",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set label(param1:String) : void
      {
         var _loc2_:Object = this.label;
         if(_loc2_ !== param1)
         {
            this._102727412label = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label",_loc2_,param1));
            }
         }
      }
   }
}
