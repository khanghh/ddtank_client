package wasteRecycle.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Timer;
   import wasteRecycle.WasteRecycleController;
   
   public class WasteRecycleTurnView extends Sprite implements Disposeable
   {
       
      
      private var _list:Vector.<WasteRecycleTurnItem>;
      
      private var _timer:Timer;
      
      private var _playLabel:Array;
      
      private var _str:String;
      
      private var _playCount:int;
      
      public function WasteRecycleTurnView(){super();}
      
      private function init() : void{}
      
      public function playAction(param1:int, param2:String) : void{}
      
      private function setPlayLabel(param1:int) : void{}
      
      private function __onTimer(param1:Event) : void{}
      
      private function __onPlayComplete(param1:Event) : void{}
      
      private function __onShineComplete(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
