package luckStar
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import luckStar.event.LuckStarEvent;
   import luckStar.manager.LuckStarManager;
   import luckStar.view.LuckStarFrame;
   
   public class LuckStarController
   {
      
      private static var _instance:LuckStarController;
       
      
      private var _frame:LuckStarFrame;
      
      public function LuckStarController(param1:PrivateClass){super();}
      
      public static function get Instance() : LuckStarController{return null;}
      
      public function setup() : void{}
      
      private function __onLoaderLuckStarIcon(param1:Event) : void{}
      
      private function __onOpenLuckStarFrame(param1:Event) : void{}
      
      private function __onFrameClose(param1:FrameEvent) : void{}
      
      private function _onLuckyStarEvent(param1:LuckStarEvent) : void{}
      
      private function __onUpdateReward(param1:Event) : void{}
      
      private function __onTurnGoodsInfo(param1:Event) : void{}
      
      private function __onAllGoodsInfo(param1:Event) : void{}
      
      public function updateLuckyStarRank(param1:Object) : void{}
      
      public function get openState() : Boolean{return false;}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
