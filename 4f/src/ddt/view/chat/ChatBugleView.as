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
      
      public function ChatBugleView(){super();}
      
      public static function get instance() : ChatBugleView{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      private function __onAddChat(param1:ChatEvent) : void{}
      
      private function checkShowTimer() : void{}
      
      private function __showTimer(param1:Event) : void{}
      
      private function checkPlay() : void{}
      
      public function show() : void{}
      
      public function updatePos() : void{}
      
      private function removeAllBuggleAnimations() : void{}
      
      public function hide() : void{}
      
      private function removeView() : void{}
   }
}

class ChatBugleData
{
    
   
   public var content:String;
   
   public var BugleType:int;
   
   public var subBugleType:int;
   
   function ChatBugleData(param1:String, param2:int, param3:int){super();}
}
