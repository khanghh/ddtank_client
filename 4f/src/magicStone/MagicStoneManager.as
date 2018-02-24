package magicStone
{
   import com.pickgliss.ui.LayerManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.MainToolBar;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import magicStone.data.MagicStoneTempAnalyer;
   import magicStone.data.MgStoneTempVO;
   import magicStone.event.MagicStoneEvent;
   import trainer.view.NewHandContainer;
   
   public class MagicStoneManager extends EventDispatcher
   {
      
      private static var _instance:MagicStoneManager;
       
      
      private var _mgStoneTempArr:Array;
      
      private var _upgradeMC:MovieClip;
      
      public var upTo40Flag:Boolean = false;
      
      public function MagicStoneManager(){super();}
      
      public static function get instance() : MagicStoneManager{return null;}
      
      public function disposeView() : void{}
      
      public function show() : void{}
      
      public function loadMgStoneTempComplete(param1:MagicStoneTempAnalyer) : void{}
      
      public function fillPropertys(param1:ItemTemplateInfo) : void{}
      
      public function getNeedExp(param1:int, param2:int) : int{return 0;}
      
      public function getNeedExpPerLevel(param1:int, param2:int) : int{return 0;}
      
      public function getExpOfCurLevel(param1:int, param2:int) : int{return 0;}
      
      public function weakGuide(param1:int, param2:DisplayObjectContainer = null) : void{}
      
      public function removeWeakGuide(param1:int) : void{}
   }
}
