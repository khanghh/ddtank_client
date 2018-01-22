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
      
      public function GodCardRaiseDivineCardsLoader()
      {
         _displayCards = new Dictionary();
         _loaderDic = new Dictionary();
         super();
      }
      
      public function loadCards(param1:Array, param2:Function = null) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         _backFun = param2;
         _loaderCount = param1.length;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            if(_displayCards.hasOwnProperty(param1[_loc5_]))
            {
               _loaderCount = _loaderCount - 1;
            }
            else
            {
               _loc3_ = GodCardRaiseManager.Instance.godCardListInfoList[param1[_loc5_]];
               _loc4_ = LoadResourceManager.Instance.createLoader(PathManager.solveGodCardRaisePath(_loc3_.Pic),0);
               _loc4_.addEventListener("complete",__picComplete);
               LoadResourceManager.Instance.startLoad(_loc4_);
               _loaderDic[_loc4_] = param1[_loc5_];
            }
            _loc5_++;
         }
         if(_loaderCount <= 0)
         {
            if(_backFun != null)
            {
               _backFun();
            }
            dispatchEvent(new Event("complete"));
         }
      }
      
      private function __picComplete(param1:LoaderEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         param1.loader.removeEventListener("complete",__picComplete);
         if(param1.loader.isSuccess)
         {
            _loc3_ = param1.loader.content as Bitmap;
            _loc2_ = _loaderDic[param1.loader];
            _displayCards[_loc2_] = _loc3_;
         }
         _loaderCount = _loaderCount - 1;
         if(_loaderCount - 1 <= 0)
         {
            if(_backFun != null)
            {
               _backFun();
            }
            dispatchEvent(new Event("complete"));
         }
      }
      
      public function get displayCards() : Dictionary
      {
         return _displayCards;
      }
      
      public function dispose() : void
      {
         if(_displayCards)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _displayCards;
            for each(var _loc1_ in _displayCards)
            {
               ObjectUtils.disposeObject(_loc1_);
            }
         }
         _displayCards = null;
         _loaderCount = 0;
         _backFun = null;
         _loaderDic = null;
      }
   }
}
