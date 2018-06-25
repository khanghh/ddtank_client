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
      
      public function loadCards($cards:Array, $backFun:Function = null) : void
      {
         var i:int = 0;
         var cardInfo:* = null;
         var loaderPic:* = null;
         _backFun = $backFun;
         _loaderCount = $cards.length;
         for(i = 0; i < $cards.length; )
         {
            if(_displayCards.hasOwnProperty($cards[i]))
            {
               _loaderCount = _loaderCount - 1;
            }
            else
            {
               cardInfo = GodCardRaiseManager.Instance.godCardListInfoList[$cards[i]];
               loaderPic = LoadResourceManager.Instance.createLoader(PathManager.solveGodCardRaisePath(cardInfo.Pic),0);
               loaderPic.addEventListener("complete",__picComplete);
               LoadResourceManager.Instance.startLoad(loaderPic);
               _loaderDic[loaderPic] = $cards[i];
            }
            i++;
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
      
      private function __picComplete(evt:LoaderEvent) : void
      {
         var _picBmp:* = null;
         var cardId:int = 0;
         evt.loader.removeEventListener("complete",__picComplete);
         if(evt.loader.isSuccess)
         {
            _picBmp = evt.loader.content as Bitmap;
            cardId = _loaderDic[evt.loader];
            _displayCards[cardId] = _picBmp;
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
            for each(var bmp in _displayCards)
            {
               ObjectUtils.disposeObject(bmp);
            }
         }
         _displayCards = null;
         _loaderCount = 0;
         _backFun = null;
         _loaderDic = null;
      }
   }
}
