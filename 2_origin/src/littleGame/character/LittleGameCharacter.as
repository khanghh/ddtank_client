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
      
      public function LittleGameCharacter(playerInfo:PlayerInfo, littleGameId:int = 1)
      {
         _playerInfo = playerInfo;
         var recordColor:Array = _playerInfo.Colors.split(",");
         hasFaceColor = Boolean(recordColor[5]);
         hasClothColor = Boolean(recordColor[4]);
         _loader = new LittleGameCharaterLoader(_playerInfo,littleGameId);
         _loader.load(onComplete);
         super(null,null,"",230,175);
      }
      
      public static function setup() : void
      {
         onXmlComplete = function(event:Event):void
         {
            event.currentTarget.removeEventListener("complete",onXmlComplete);
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
      
      public function set isComplete(value:Boolean) : void
      {
         _isComplete = value;
      }
      
      override public function doAction(action:String) : void
      {
         play();
         var a:ComplexBitmapAction = _actionSet.getAction(action) as ComplexBitmapAction;
         if(a)
         {
            if(_currentAction == null)
            {
               currentAction = a;
            }
            else if(a.priority >= _currentAction.priority)
            {
               var _loc5_:int = 0;
               var _loc4_:* = _currentAction.assets;
               for each(var item in _currentAction.assets)
               {
                  item.stop();
                  removeItem(item);
               }
               _currentAction.reset();
               currentAction = a;
               if(action.indexOf("back") != -1)
               {
                  _items.reverse();
               }
            }
         }
         _currentAct = action;
      }
      
      override protected function set currentAction(action:ComplexBitmapAction) : void
      {
         _currentAction = action;
         _autoStop = _currentAction.endStop;
         var _loc4_:int = 0;
         var _loc3_:* = _currentAction.assets;
         for each(var item1 in _currentAction.assets)
         {
            item1.play();
            addItem(item1);
         }
         if(!StringUtils.isEmpty(_currentAction.sound) && _soundEnabled && (_currentAct != action.name || !_currentSoundPlayed))
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
         var bmds:Dictionary = new Dictionary();
         bmds["head"] = _headBmd;
         bmds["body"] = _bodyBmd;
         bmds["effect"] = _loader.getContent()[2];
         bmds["specialHead"] = _loader.getContent()[4];
         assets = bmds;
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
      
      private function updateRenderSource(resource:String, renderData:BitmapData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _bitmapRendItems;
         for each(var item in _bitmapRendItems)
         {
            if(item.sourceName == resource)
            {
               item.source = renderData;
               if(item is CrossFrameItem)
               {
                  CrossFrameItem(item).frames = CrossFrameItem(item).frames;
               }
            }
         }
      }
      
      public function setFunnyHead(type:uint = 0) : void
      {
         if(headBmds == null || type > headBmds.length - 1)
         {
            return;
         }
         updateRenderSource("specialHead",headBmds[type]);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
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
            for(i = 0; i < headBmds.length; )
            {
               if(headBmds[i])
               {
                  headBmds[i].dispose();
               }
               i++;
            }
         }
         headBmds = null;
      }
   }
}
