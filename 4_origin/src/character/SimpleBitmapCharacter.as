package character
{
   import character.action.ActionSet;
   import character.action.BaseAction;
   import character.action.SimpleFrameAction;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.events.PropertyChangeEvent;
   
   public class SimpleBitmapCharacter extends CrossFrameItem implements ICharacter
   {
       
      
      private var _actionSet:ActionSet;
      
      private var _currentAction:SimpleFrameAction;
      
      private var _label:String = "";
      
      private var _registerPoint:Point;
      
      private var _rect:Rectangle;
      
      protected var _soundEnabled:Boolean = false;
      
      public function SimpleBitmapCharacter(param1:BitmapData, param2:XML = null, param3:String = "", param4:Number = 0, param5:Number = 0, param6:String = "original", param7:Boolean = false)
      {
         this._registerPoint = new Point(0,0);
         this._actionSet = new ActionSet();
         if(param2)
         {
            this.description = param2;
         }
         this._label = param3;
         super(param4,param5,param1,null,param6,param7);
         _type = CharacterType.SIMPLE_BITMAP_TYPE;
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
      
      public function set description(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:SimpleFrameAction = null;
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
         var _loc2_:XMLList = param1..action;
         for each(_loc3_ in _loc2_)
         {
            _loc6_ = new SimpleFrameAction(CharacterUtils.creatFrames(_loc3_.@frames),_loc3_.@name,_loc3_.@next,_loc3_.@priority);
            this._actionSet.addAction(_loc6_);
            _loc6_.endStop = String(_loc3_.@endStop) == "true";
            _loc6_.sound = _loc3_.@sound;
         }
         this._currentAction = this._actionSet.currentAction as SimpleFrameAction;
      }
      
      private function set _102727412label(param1:String) : void
      {
         this._label = param1;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function hasAction(param1:String) : Boolean
      {
         return this._actionSet.getAction(param1) != null;
      }
      
      public function addAction(param1:BaseAction) : void
      {
         if(param1 is SimpleFrameAction)
         {
            this._actionSet.addAction(param1);
            if(this._currentAction == null)
            {
               this._currentAction = param1 as SimpleFrameAction;
               this.doAction(this._currentAction.name);
            }
            return;
         }
         throw new Error("SimpleBitmapCharacter\'s action must be SimpleFrameAction");
      }
      
      public function get actions() : Array
      {
         return this._actionSet.actions;
      }
      
      public function removeAction(param1:String) : void
      {
         this._actionSet.removeAction(param1);
         dispatchEvent(new CharacterEvent(CharacterEvent.REMOVE_ACTION));
      }
      
      public function doAction(param1:String) : void
      {
         play();
         var _loc2_:SimpleFrameAction = this._actionSet.getAction(param1) as SimpleFrameAction;
         if(_loc2_ == null)
         {
            return;
         }
         if(this._currentAction)
         {
            if(_loc2_.priority >= this._currentAction.priority)
            {
               this._currentAction = _loc2_;
               _frames = _loc2_.frames;
               _len = _frames.length;
               _index = 0;
               _autoStop = this._currentAction.endStop;
               if(this._currentAction.sound != "" && this._soundEnabled)
               {
                  CharacterSoundManager.instance.play(this._currentAction.sound);
               }
            }
         }
         else
         {
            this._currentAction = _loc2_;
            _frames = _loc2_.frames;
            _len = _frames.length;
            _index = 0;
            _autoStop = this._currentAction.endStop;
            if(this._currentAction.sound != "" && this._soundEnabled)
            {
               CharacterSoundManager.instance.play(this._currentAction.sound);
            }
         }
      }
      
      override protected function update() : void
      {
         if(_index >= _len - 1 && !_autoStop)
         {
            if(this._currentAction)
            {
               this.doAction(this._currentAction.nextAction);
            }
         }
         super.update();
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
         _loc1_.@resource = _sourceName;
         _loc1_.@width = _itemWidth;
         _loc1_.@height = _itemHeight;
         _loc1_.@label = this._label;
         _loc1_.@registerX = this._registerPoint.x;
         _loc1_.@registerY = this._registerPoint.y;
         _loc1_.@rect = [this.rect.x,this.rect.y,this.rect.width,this.rect.height].join("|");
         _loc1_.appendChild(this._actionSet.toXml());
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         this._actionSet.dispose();
         this._actionSet = null;
         this._currentAction = null;
         super.dispose();
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
