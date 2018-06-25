package ddt.view.chat
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.StateManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChatBugleView extends Sprite
   {
      
      private static const BIG_BUGLE:uint = 1;
      
      private static const SMALL_BUGLE:uint = 2;
      
      private static const ADMIN_NOTICE:uint = 3;
      
      private static const DEFY_AFFICHE:uint = 3;
      
      private static const CROSS_BUGLE:uint = 4;
      
      private static const CROSS_NOTICE:uint = 5;
      
      private static const MOVE_STEP:uint = 3;
      
      private static var _instance:ChatBugleView;
       
      
      private var _showTimer:TimerJuggler;
      
      private var _bugleList:Array;
      
      private var _currentBugle:String;
      
      private var _currentBugleType:int;
      
      private var _currentBigBugleType:int;
      
      private var _buggleTypeMc:ScaleFrameImage;
      
      private var _bg:Bitmap;
      
      private var _contentTxt:FilterFrameText;
      
      private var _animationTxt:FilterFrameText;
      
      private var _bigBugleAnimations:Vector.<MovieClip>;
      
      private var _fieldRect:Rectangle;
      
      public function ChatBugleView()
      {
         super();
      }
      
      public static function get instance() : ChatBugleView
      {
         if(_instance == null)
         {
            _instance = new ChatBugleView();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _bigBugleAnimations = new Vector.<MovieClip>(6);
         _bg = ComponentFactory.Instance.creatBitmap("asset.chat.BugleViewBg");
         _buggleTypeMc = ComponentFactory.Instance.creatComponentByStylename("chat.BugleViewType");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("chat.BugleViewText");
         _animationTxt = ComponentFactory.Instance.creatComponentByStylename("chat.BugleAnimationText");
         PositionUtils.setPos(this,"chat.BugleViewPos");
         _showTimer = TimerManager.getInstance().addTimerJuggler(3000);
         _bugleList = [];
         _currentBugleType = -1;
         addChild(_bg);
         addChild(_buggleTypeMc);
         addChild(_contentTxt);
         mouseChildren = false;
         mouseEnabled = false;
         initEvent();
      }
      
      private function initEvent() : void
      {
         _showTimer.addEventListener("timer",__showTimer);
         ChatManager.Instance.model.addEventListener("addChat",__onAddChat);
      }
      
      private function __onAddChat(event:ChatEvent) : void
      {
         var offset:int = 0;
         var ItemID:Number = NaN;
         var TemplateID:int = 0;
         var info:* = null;
         var index:* = 0;
         if(ChatManager.Instance.state == 4 || ChatManager.Instance.state == 18 || ChatManager.Instance.state == 20 || ChatManager.Instance.state == 24 || ChatManager.Instance.isInGame || ChatManager.Instance.state == 29)
         {
            return;
         }
         var o:ChatData = event.data as ChatData;
         var result:* = "";
         var leftPattern:RegExp = /&lt;/g;
         var rightPattern:RegExp = /&gt;/g;
         var chatMsg:String = o.msg.replace(leftPattern,"<").replace(rightPattern,">");
         chatMsg = Helpers.deCodeString(chatMsg);
         if(o.link)
         {
            offset = 0;
            o.link.sortOn("index");
            var _loc16_:int = 0;
            var _loc15_:* = o.link;
            for each(var i in o.link)
            {
               ItemID = i.ItemID;
               TemplateID = i.TemplateID;
               info = ItemManager.Instance.getTemplateById(TemplateID);
               index = uint(i.index + offset);
               if(info == null)
               {
                  if(TemplateID == 0)
                  {
                     chatMsg = chatMsg.substring(0,index) + "[" + LanguageMgr.GetTranslation("tank.view.card.chatLinkText0") + "]" + chatMsg.substring(index);
                     offset = offset + LanguageMgr.GetTranslation("tank.view.card.chatLinkText0").length;
                  }
                  else
                  {
                     chatMsg = chatMsg.substring(0,index) + "[" + String(TemplateID) + LanguageMgr.GetTranslation("tank.view.card.chatLinkText") + "]" + chatMsg.substring(index);
                     offset = offset + (String(TemplateID) + LanguageMgr.GetTranslation("tank.view.card.chatLinkText")).length;
                  }
               }
               else
               {
                  chatMsg = chatMsg.substring(0,index) + "[" + info.Name + "]" + chatMsg.substring(index);
                  offset = offset + info.Name.length;
               }
            }
         }
         var BugleType:int = 1;
         var BigBugleType:int = 0;
         if(o.channel == 1)
         {
            BugleType = 2;
            result = "[" + o.sender + LanguageMgr.GetTranslation("tank.view.common.BuggleView.small") + chatMsg;
         }
         else if(o.channel == 0)
         {
            BugleType = 1;
            if(o.bigBuggleType != 0)
            {
               BigBugleType = o.bigBuggleType;
               result = "[" + o.sender + "]:" + chatMsg;
            }
            else
            {
               BigBugleType = 0;
               result = "[" + o.sender + LanguageMgr.GetTranslation("tank.view.common.BuggleView.big") + chatMsg;
            }
         }
         else if(o.channel == 15)
         {
            BugleType = 4;
            result = "[" + o.sender + LanguageMgr.GetTranslation("tank.view.common.BuggleView.cross") + chatMsg;
         }
         else if(o.channel == 12)
         {
            BugleType = 3;
            result = chatMsg;
         }
         else if(o.channel == 11)
         {
            BugleType = 3;
            result = chatMsg;
         }
         else if(o.channel == 6 || o.channel == 7)
         {
            if(o.type == 1 || o.type == 3 || o.type == 9 || o.type == 20 || o.type == 21)
            {
               BugleType = 3;
               result = chatMsg;
            }
            else
            {
               return;
            }
         }
         else
         {
            return;
         }
         _bugleList.push(new ChatBugleData(result,BugleType,BigBugleType));
         checkPlay();
      }
      
      private function checkShowTimer() : void
      {
         _showTimer.stop();
         _showTimer.reset();
         hide();
         _showTimer.start();
      }
      
      private function __showTimer(evt:Event) : void
      {
         _showTimer.stop();
         _showTimer.reset();
         hide();
      }
      
      private function checkPlay() : void
      {
         var bugleData:* = null;
         var _currentBugle:* = null;
         trace(_bugleList.length);
         if(PlayerManager.Instance.Self.Grade > 1)
         {
            if(_bugleList.length > 0)
            {
               bugleData = _bugleList.splice(0,1)[0];
               _currentBugle = bugleData.content;
               _currentBugleType = bugleData.BugleType;
               _currentBigBugleType = bugleData.subBugleType;
               if(_animationTxt.parent)
               {
                  _animationTxt.parent.removeChild(_animationTxt);
               }
               removeAllBuggleAnimations();
               _buggleTypeMc.setFrame(_currentBugleType);
               addChild(_bg);
               addChild(_buggleTypeMc);
               addChild(_contentTxt);
               if(_currentBugleType == 1)
               {
                  _contentTxt.textColor = ChatFormats.getColorByChannel(0);
                  if(_currentBigBugleType != 0)
                  {
                     if(_contentTxt.parent)
                     {
                        _contentTxt.parent.removeChild(_contentTxt);
                     }
                     if(_buggleTypeMc.parent)
                     {
                        _buggleTypeMc.parent.removeChild(_buggleTypeMc);
                     }
                     if(_bg.parent)
                     {
                        _bg.parent.removeChild(_bg);
                     }
                     _animationTxt.textColor = ChatFormats.getColorByBigBuggleType(_currentBigBugleType - 1);
                     if(_bigBugleAnimations[_currentBigBugleType - 1] == null)
                     {
                        _bigBugleAnimations[_currentBigBugleType - 1] = ComponentFactory.Instance.creat("chat.BugleAnimation_" + (_currentBigBugleType - 1).toString());
                        PositionUtils.setPos(_bigBugleAnimations[_currentBigBugleType - 1],"chat.BugleAnimationPos_" + (_currentBigBugleType - 1).toString());
                     }
                     _animationTxt.x = _bigBugleAnimations[_currentBigBugleType - 1].x;
                     _animationTxt.y = _bigBugleAnimations[_currentBigBugleType - 1].y;
                     _bigBugleAnimations[_currentBigBugleType - 1].play();
                     addChild(_bigBugleAnimations[_currentBigBugleType - 1]);
                     addChild(_animationTxt);
                     _animationTxt.text = _currentBugle;
                     checkShowTimer();
                     show();
                     return;
                  }
               }
               else if(_currentBugleType == 2)
               {
                  _contentTxt.textColor = ChatFormats.getColorByChannel(1);
               }
               else if(_currentBugleType == 3)
               {
                  _contentTxt.textColor = ChatFormats.getColorByChannel(8);
               }
               else if(_currentBugleType == 3)
               {
                  _contentTxt.textColor = ChatFormats.getColorByChannel(11);
               }
               else if(_currentBugleType == 4)
               {
                  _contentTxt.textColor = ChatFormats.getColorByChannel(15);
               }
               else if(_currentBugleType == 5)
               {
                  _contentTxt.textColor = ChatFormats.getColorByChannel(12);
               }
               _contentTxt.text = _currentBugle;
               checkShowTimer();
               show();
            }
            else
            {
               hide();
            }
         }
      }
      
      public function show() : void
      {
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d" || StateManager.currentStateType == "shop" || StateManager.currentStateType == "hotSpringRoom" && ChatManager.Instance.state == 18 || StateManager.currentStateType == "trainer1" || StateManager.currentStateType == "trainer2" || StateManager.currentStateType == "loadingTrainer" || StateManager.currentStateType == "fightLabGameView" || StateManager.currentStateType == "worldboss" || StateManager.currentStateType == "demon_chi_you" || StateManager.currentStateType == "consortia_domain" || StateManager.currentStateType == "consortiaGuard")
         {
            return;
         }
         updatePos();
         if(_currentBugleType == 3)
         {
            LayerManager.Instance.addToLayer(this,4,false,0,false);
            this.parent.setChildIndex(this,this.parent.numChildren - 1);
            y = y + 30;
            this.visible = true;
            TweenLite.to(this,0.25,{"y":y - 30});
            return;
         }
         if(SharedManager.Instance.showTopMessageBar)
         {
            LayerManager.Instance.addToLayer(this,4,false,0,false);
            this.parent.setChildIndex(this,this.parent.numChildren - 1);
            y = y + 30;
            this.visible = true;
            TweenLite.to(this,0.25,{"y":y - 30});
         }
         else
         {
            hide();
         }
      }
      
      public function updatePos() : void
      {
         x = 9;
         y = 12;
      }
      
      private function removeAllBuggleAnimations() : void
      {
         var i:int = 0;
         if(_bigBugleAnimations)
         {
            for(i = 0; i < _bigBugleAnimations.length; )
            {
               if(_bigBugleAnimations[i])
               {
                  if(_bigBugleAnimations[i].parent)
                  {
                     _bigBugleAnimations[i].parent.removeChild(_bigBugleAnimations[i]);
                  }
                  _bigBugleAnimations[i].stop();
               }
               i++;
            }
         }
      }
      
      public function hide() : void
      {
         TweenLite.to(this,0.5,{
            "y":y - 60,
            "onComplete":removeView
         });
      }
      
      private function removeView() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         removeAllBuggleAnimations();
         if(_animationTxt && _animationTxt.parent)
         {
            _animationTxt.parent.removeChild(_animationTxt);
         }
         y = y + 60;
      }
   }
}

class ChatBugleData
{
    
   
   public var content:String;
   
   public var BugleType:int;
   
   public var subBugleType:int;
   
   function ChatBugleData(c:String, t:int, st:int)
   {
      super();
      content = c;
      BugleType = t;
      subBugleType = st;
   }
}
