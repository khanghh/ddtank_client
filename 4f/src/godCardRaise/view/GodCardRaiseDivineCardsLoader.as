package godCardRaise.view
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListInfo;
   
   public class GodCardRaiseDivineCardsLoader extends EventDispatcher implements Disposeable
   {
       
      
      private var _displayCards:Dictionary;
      
      private var _loaderCount:int;
      
      private var _backFun:Function;
      
      private var _loaderDic:Dictionary;
      
      public function GodCardRaiseDivineCardsLoader(){super();}
      
      public function loadCards(param1:Array, param2:Function = null) : void{}
      
      private function __picComplete(param1:LoaderEvent) : void{}
      
      public function get displayCards() : Dictionary{return null;}
      
      public function dispose() : void{}
   }
}
