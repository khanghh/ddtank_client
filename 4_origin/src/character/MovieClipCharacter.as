package character
{
   import character.action.ActionSet;
   import character.action.BaseAction;
   import character.action.MovieClipAction;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import mx.events.PropertyChangeEvent;
   
   public class MovieClipCharacter extends Sprite implements ICharacter
   {
       
      
      private var _assets:Dictionary;
      
      private var _actionSet:ActionSet;
      
      private var _currentAction:MovieClipAction;
      
      private var _label:String = "";
      
      private var _autoStop:Boolean;
      
      private var _isPlaying:Boolean = true;
      
      private var _type:int;
      
      private var _registerPoint:Point;
      
      private var _rect:Rectangle;
      
      private var _realRender:Boolean;
      
      protected var _soundEnabled:Boolean = false;
      
      public function MovieClipCharacter(param1:Dictionary, param2:XML = null, param3:String = "", param4:Boolean = false)
      {
         this._registerPoint = new Point(0,0);
         super();
         this._type = CharacterType.MOVIECLIP_TYPE;
         this._actionSet = new ActionSet();
         this._assets = param1;
         this._autoStop = param4;
         if(param2)
         {
            this.description = param2;
         }
         this._label = param3;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
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
      
      public function getActionFrames(param1:String) : int
      {
         var _loc2_:BaseAction = this._actionSet.getAction(param1);
         if(_loc2_)
         {
            return _loc2_.len;
         }
         return 0;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this._isPlaying)
         {
            if(this._currentAction)
            {
               if(this._currentAction.isEnd)
               {
                  if(this._autoStop)
                  {
                     MovieClip(this._currentAction.asset).stop();
                  }
                  else
                  {
                     this.doAction(this._currentAction.nextAction);
                  }
               }
            }
         }
         else if(this._currentAction)
         {
            MovieClip(this._currentAction.asset).stop();
         }
      }
      
      public function get actions() : Array
      {
         return this._actionSet.actions;
      }
      
      public function set description(param1:XML) : void
      {
         var action:XML = null;
         var r:String = null;
         var ar:Array = null;
         var resource:MovieClip = null;
         var a:MovieClipAction = null;
         var cls:Class = null;
         var des:XML = param1;
         this._actionSet = new ActionSet();
         var actions:XMLList = des..action;
         this._label = des.@label;
         if(des.hasOwnProperty("@registerX"))
         {
            this._registerPoint.x = des.@registerX;
         }
         if(des.hasOwnProperty("@registerY"))
         {
            this._registerPoint.y = des.@registerY;
         }
         if(des.hasOwnProperty("@rect"))
         {
            r = String(des.@rect);
            this._rect = new Rectangle();
            ar = r.split("|");
            this._rect.x = ar[0];
            this._rect.y = ar[1];
            this._rect.width = ar[2];
            this._rect.height = ar[3];
         }
         for each(action in actions)
         {
            if(this._assets && this._assets[String(action.@asset)])
            {
               resource = this._assets[String(action.@asset)];
            }
            else
            {
               try
               {
                  cls = getDefinitionByName(String(action.@asset)) as Class;
                  resource = new cls() as MovieClip;
                  if(this._assets == null)
                  {
                     this._assets = new Dictionary();
                  }
                  this._assets[String(action.@resource)] = resource;
               }
               catch(e:Error)
               {
                  trace("not found resource when creat movieClipCharacter");
               }
            }
            a = new MovieClipAction(resource,action.@name,action.@next,action.@priority);
            a.endStop = String(action.@endStop) == "true";
            a.sound = action.@sound;
            this._actionSet.addAction(a);
         }
         this.currentAction = this._actionSet.currentAction as MovieClipAction;
      }
      
      private function set currentAction(param1:MovieClipAction) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._currentAction = param1;
         this._autoStop = this._currentAction.endStop;
         var _loc2_:MovieClip = this._currentAction.asset as MovieClip;
         _loc2_.gotoAndPlay(1);
         addChild(_loc2_);
         if(this._currentAction.sound != "" && this._soundEnabled)
         {
            CharacterSoundManager.instance.play(this._currentAction.sound);
         }
      }
      
      public function get itemWidth() : Number
      {
         return width;
      }
      
      public function get itemHeight() : Number
      {
         return height;
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
      
      public function doAction(param1:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:MovieClipAction = this._actionSet.getAction(param1) as MovieClipAction;
         if(_loc2_)
         {
            if(this._currentAction != null)
            {
               if(_loc2_.priority >= this._currentAction.priority)
               {
                  _loc3_ = this._currentAction.asset as MovieClip;
                  _loc3_.gotoAndStop(1);
                  if(contains(_loc3_))
                  {
                     removeChild(_loc3_);
                  }
                  this._currentAction.reset();
                  this.currentAction = _loc2_;
               }
            }
            else
            {
               this.currentAction = _loc2_;
            }
         }
      }
      
      public function addAction(param1:BaseAction) : void
      {
         this._actionSet.addAction(param1);
         dispatchEvent(new CharacterEvent(CharacterEvent.ADD_ACTION,param1));
      }
      
      public function toXml() : XML
      {
         var _loc1_:XML = <character></character>;
         _loc1_.@type = this._type;
         _loc1_.@label = this._label;
         _loc1_.@registerX = this._registerPoint.x;
         _loc1_.@registerY = this._registerPoint.y;
         _loc1_.@rect = [this.rect.x,this.rect.y,this.rect.width,this.rect.height].join("|");
         _loc1_.appendChild(this._actionSet.toXml());
         return _loc1_;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function removeAction(param1:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:BaseAction = this._actionSet.getAction(param1);
         if(this._currentAction == _loc2_)
         {
            _loc3_ = this._currentAction.asset as MovieClip;
            _loc3_.gotoAndStop(1);
            if(contains(_loc3_))
            {
               removeChild(_loc3_);
            }
            this._currentAction = null;
         }
         this._actionSet.removeAction(param1);
         dispatchEvent(new CharacterEvent(CharacterEvent.REMOVE_ACTION));
      }
      
      public function get registerPoint() : Point
      {
         return this._registerPoint;
      }
      
      public function get rect() : Rectangle
      {
         if(this._rect == null)
         {
            this._rect = new Rectangle(0,0,this.itemWidth,this.itemHeight);
         }
         return this._rect;
      }
      
      public function dispose() : void
      {
         var _loc1_:MovieClip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         for each(_loc1_ in this._assets)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_.stop();
         }
         this._actionSet.dispose();
         this._actionSet = null;
         this._currentAction = null;
      }
      
      public function get assets() : Dictionary
      {
         return this._assets;
      }
      
      public function get realRender() : Boolean
      {
         return this._realRender;
      }
      
      private function set _2032707372realRender(param1:Boolean) : void
      {
         if(this._realRender == param1)
         {
            return;
         }
         this._realRender = param1;
         if(this._realRender)
         {
            if(this._currentAction && this._currentAction.asset)
            {
               addChild(this._currentAction.asset);
            }
         }
         else if(this._currentAction && this._currentAction.asset && contains(this._currentAction.asset))
         {
            removeChild(this._currentAction.asset);
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
      
      [Bindable(event="propertyChange")]
      public function set realRender(param1:Boolean) : void
      {
         var _loc2_:Object = this.realRender;
         if(_loc2_ !== param1)
         {
            this._2032707372realRender = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"realRender",_loc2_,param1));
            }
         }
      }
   }
}
