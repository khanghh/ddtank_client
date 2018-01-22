package littleGame.character
{
   import character.ComplexBitmapCharacter;
   import character.action.ComplexBitmapAction;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class LittleGameCharacter extends ComplexBitmapCharacter implements Disposeable
   {
      
      public static const WIDTH:Number = 230;
      
      public static const HEIGHT:Number = 175;
      
      public static var DEFINE:XML;
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _headBmd:BitmapData;
      
      private var _bodyBmd:BitmapData;
      
      private var headBmds:Vector.<BitmapData>;
      
      private var _loader:LittleGameCharaterLoader;
      
      private var hasFaceColor:Boolean = false;
      
      private var hasClothColor:Boolean = false;
      
      private var _isComplete:Boolean = false;
      
      private var _currentAct:String;
      
      private var _currentSoundPlayed:Boolean;
      
      public function LittleGameCharacter(param1:PlayerInfo, param2:int = 1)
      {
         _playerInfo = param1;
         var _loc3_:Array = _playerInfo.Colors.split(",");
         hasFaceColor = Boolean(_loc3_[5]);
         hasClothColor = Boolean(_loc3_[4]);
         _loader = new LittleGameCharaterLoader(_playerInfo,param2);
         _loader.load(onComplete);
         super(null,null,"",230,175);
      }
      
      public static function setup() : void
      {
         onXmlComplete = function(param1:Event):void
         {
            param1.currentTarget.removeEventListener("complete",onXmlComplete);
            DEFINE = XML(loader.data);
         };
         var loader:URLLoader = new URLLoader();
         loader.addEventListener("complete",onXmlComplete);
         loader.load(new URLRequest(PathManager.FLASHSITE + "characterdefine.xml?rnd=" + Math.random()));
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
      
      public function set isComplete(param1:Boolean) : void
      {
         _isComplete = param1;
      }
      
      override public function doAction(param1:String) : void
      {
         play();
         var _loc3_:ComplexBitmapAction = _actionSet.getAction(param1) as ComplexBitmapAction;
         if(_loc3_)
         {
            if(_currentAction == null)
            {
               currentAction = _loc3_;
            }
            else if(_loc3_.priority >= _currentAction.priority)
            {
               var _loc5_:int = 0;
               var _loc4_:* = _currentAction.assets;
               for each(var _loc2_ in _currentAction.assets)
               {
                  _loc2_.stop();
                  removeItem(_loc2_);
               }
               _currentAction.reset();
               currentAction = _loc3_;
               if(param1.indexOf("back") != -1)
               {
                  _items.reverse();
               }
            }
         }
         _currentAct = param1;
      }
      
      override protected function set currentAction(param1:ComplexBitmapAction) : void
      {
         _currentAction = param1;
         _autoStop = _currentAction.endStop;
         var _loc4_:int = 0;
         var _loc3_:* = _currentAction.assets;
         for each(var _loc2_ in _currentAction.assets)
         {
            _loc2_.play();
            addItem(_loc2_);
         }
         if(!StringUtils.isEmpty(_currentAction.sound) && _soundEnabled && (_currentAct != param1.name || !_currentSoundPlayed))
         {
            SoundManager.instance.play(_currentAction.sound);
            _currentSoundPlayed = true;
         }
      }
      
      override protected function update() : void
      {
         super.update();
      }
      
      private function onComplete() : void
      {
         _headBmd = _loader.getContent()[0];
         _bodyBmd = _loader.getContent()[1];
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["head"] = _headBmd;
         _loc1_["body"] = _bodyBmd;
         _loc1_["effect"] = _loader.getContent()[2];
         _loc1_["specialHead"] = _loader.getContent()[4];
         assets = _loc1_;
         headBmds = new Vector.<BitmapData>();
         headBmds.push(_loader.getContent()[3],_loader.getContent()[4],_loader.getContent()[5]);
         .super.description = DEFINE;
         dispatchEvent(new Event("complete"));
         if(_currentAct != null)
         {
            doAction(_currentAct);
         }
         _isComplete = true;
      }
      
      override public function get actions() : Array
      {
         return _actionSet.actions;
      }
      
      private function updateRenderSource(param1:String, param2:BitmapData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _bitmapRendItems;
         for each(var _loc3_ in _bitmapRendItems)
         {
            if(_loc3_.sourceName == param1)
            {
               _loc3_.source = param2;
               if(_loc3_ is CrossFrameItem)
               {
                  CrossFrameItem(_loc3_).frames = CrossFrameItem(_loc3_).frames;
               }
            }
         }
      }
      
      public function setFunnyHead(param1:uint = 0) : void
      {
         if(headBmds == null || param1 > headBmds.length - 1)
         {
            return;
         }
         updateRenderSource("specialHead",headBmds[param1]);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         if(assets)
         {
            assets["head"] = null;
            assets["body"] = null;
            assets["effect"] = null;
            assets["specialHead"] = null;
            assets = null;
         }
         super.dispose();
         if(_headBmd)
         {
            _headBmd.dispose();
            _headBmd = null;
         }
         if(_bodyBmd && hasClothColor)
         {
            _bodyBmd.dispose();
         }
         _bodyBmd = null;
         if(_loader)
         {
            _loader.dispose();
         }
         if(hasFaceColor && headBmds)
         {
            _loc1_ = 0;
            while(_loc1_ < headBmds.length)
            {
               if(headBmds[_loc1_])
               {
                  headBmds[_loc1_].dispose();
               }
               _loc1_++;
            }
         }
         headBmds = null;
      }
   }
}
