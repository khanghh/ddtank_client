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
      
      private function __onAddChat(param1:ChatEvent) : void
      {
         var _loc13_:int = 0;
         var _loc2_:Number = NaN;
         var _loc7_:int = 0;
         var _loc11_:* = null;
         var _loc4_:* = 0;
         if(ChatManager.Instance.state == 4 || ChatManager.Instance.state == 18 || ChatManager.Instance.state == 20 || ChatManager.Instance.state == 24 || ChatManager.Instance.isInGame || ChatManager.Instance.state == 29)
         {
            return;
         }
         var _loc6_:ChatData = param1.data as ChatData;
         var _loc3_:* = "";
         var _loc5_:RegExp = /&lt;/g;
         var _loc9_:RegExp = /&gt;/g;
         var _loc14_:String = _loc6_.msg.replace(_loc5_,"<").replace(_loc9_,">");
         _loc14_ = Helpers.deCodeString(_loc14_);
         if(_loc6_.link)
         {
            _loc13_ = 0;
            _loc6_.link.sortOn("index");
            var _loc16_:int = 0;
            var _loc15_:* = _loc6_.link;
            for each(var _loc10_ in _loc6_.link)
            {
               _loc2_ = _loc10_.ItemID;
               _loc7_ = _loc10_.TemplateID;
               _loc11_ = ItemManager.Instance.getTemplateById(_loc7_);
               _loc4_ = uint(_loc10_.index + _loc13_);
               if(_loc11_ == null)
               {
                  if(_loc7_ == 0)
                  {
                     _loc14_ = _loc14_.substring(0,_loc4_) + "[" + LanguageMgr.GetTranslation("tank.view.card.chatLinkText0") + "]" + _loc14_.substring(_loc4_);
                     _loc13_ = _loc13_ + LanguageMgr.GetTranslation("tank.view.card.chatLinkText0").length;
                  }
                  else
                  {
                     _loc14_ = _loc14_.substring(0,_loc4_) + "[" + String(_loc7_) + LanguageMgr.GetTranslation("tank.view.card.chatLinkText") + "]" + _loc14_.substring(_loc4_);
                     _loc13_ = _loc13_ + (String(_loc7_) + LanguageMgr.GetTranslation("tank.view.card.chatLinkText")).length;
                  }
               }
               else
               {
                  _loc14_ = _loc14_.substring(0,_loc4_) + "[" + _loc11_.Name + "]" + _loc14_.substring(_loc4_);
                  _loc13_ = _loc13_ + _loc11_.Name.length;
               }
            }
         }
         var _loc8_:int = 1;
         var _loc12_:int = 0;
         if(_loc6_.channel == 1)
         {
            _loc8_ = 2;
            _loc3_ = "[" + _loc6_.sender + LanguageMgr.GetTranslation("tank.view.common.BuggleView.small") + _loc14_;
         }
         else if(_loc6_.channel == 0)
         {
            _loc8_ = 1;
            if(_loc6_.bigBuggleType != 0)
            {
               _loc12_ = _loc6_.bigBuggleType;
               _loc3_ = "[" + _loc6_.sender + "]:" + _loc14_;
            }
            else
            {
               _loc12_ = 0;
               _loc3_ = "[" + _loc6_.sender + LanguageMgr.GetTranslation("tank.view.common.BuggleView.big") + _loc14_;
            }
         }
         else if(_loc6_.channel == 15)
         {
            _loc8_ = 4;
            _loc3_ = "[" + _loc6_.sender + LanguageMgr.GetTranslation("tank.view.common.BuggleView.cross") + _loc14_;
         }
         else if(_loc6_.channel == 12)
         {
            _loc8_ = 3;
            _loc3_ = _loc14_;
         }
         else if(_loc6_.channel == 11)
         {
            _loc8_ = 3;
            _loc3_ = _loc14_;
         }
         else if(_loc6_.channel == 6 || _loc6_.channel == 7)
         {
            if(_loc6_.type == 1 || _loc6_.type == 3 || _loc6_.type == 9 || _loc6_.type == 20 || _loc6_.type == 21)
            {
               _loc8_ = 3;
               _loc3_ = _loc14_;
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
         _bugleList.push(new ChatBugleData(_loc3_,_loc8_,_loc12_));
         checkPlay();
      }
      
      private function checkShowTimer() : void
      {
         _showTimer.stop();
         _showTimer.reset();
         hide();
         _showTimer.start();
      }
      
      private function __showTimer(param1:Event) : void
      {
         _showTimer.stop();
         _showTimer.reset();
         hide();
      }
      
      private function checkPlay() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         trace(_bugleList.length);
         if(PlayerManager.Instance.Self.Grade > 1)
         {
            if(_bugleList.length > 0)
            {
               _loc2_ = _bugleList.splice(0,1)[0];
               _loc1_ = _loc2_.content;
               _currentBugleType = _loc2_.BugleType;
               _currentBigBugleType = _loc2_.subBugleType;
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
                     _animationTxt.text = _loc1_;
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
               _contentTxt.text = _loc1_;
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
         var _loc1_:int = 0;
         if(_bigBugleAnimations)
         {
            _loc1_ = 0;
            while(_loc1_ < _bigBugleAnimations.length)
            {
               if(_bigBugleAnimations[_loc1_])
               {
                  if(_bigBugleAnimations[_loc1_].parent)
                  {
                     _bigBugleAnimations[_loc1_].parent.removeChild(_bigBugleAnimations[_loc1_]);
                  }
                  _bigBugleAnimations[_loc1_].stop();
               }
               _loc1_++;
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
   
   function ChatBugleData(param1:String, param2:int, param3:int)
   {
      super();
      content = param1;
      BugleType = param2;
      subBugleType = param3;
   }
}
