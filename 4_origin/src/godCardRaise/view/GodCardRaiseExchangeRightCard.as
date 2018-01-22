package godCardRaise.view
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListInfo;
   
   public class GodCardRaiseExchangeRightCard extends Sprite implements Disposeable
   {
       
      
      private var _info:Object;
      
      private var _cradInfo:GodCardListInfo;
      
      private var _countTxt:FilterFrameText;
      
      private var _loaderPic:DisplayLoader;
      
      private var _picBmp:Bitmap;
      
      public function GodCardRaiseExchangeRightCard(param1:Object)
      {
         super();
         _info = param1;
         _cradInfo = GodCardRaiseManager.Instance.godCardListInfoList[_info.cardId];
         initView();
      }
      
      private function initView() : void
      {
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseExchangeRightCard.countTxt");
         addChild(_countTxt);
         _loaderPic = LoadResourceManager.Instance.createLoader(PathManager.solveGodCardRaisePath(_cradInfo.Pic),0);
         _loaderPic.addEventListener("complete",__picComplete);
         LoadResourceManager.Instance.startLoad(_loaderPic);
         updateView();
      }
      
      private function __picComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__picComplete);
         if(param1.loader.isSuccess)
         {
            _picBmp = param1.loader.content as Bitmap;
            addChild(_picBmp);
         }
      }
      
      public function updateView() : void
      {
         var _loc1_:int = GodCardRaiseManager.Instance.model.cards[_info.cardId];
         _countTxt.text = LanguageMgr.GetTranslation("godCardRaiseExchangeRightCard.countTxtMsg",_loc1_,_info.cardCount);
      }
      
      public function dispose() : void
      {
         if(_loaderPic)
         {
            _loaderPic.removeEventListener("complete",__picComplete);
            _loaderPic = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _countTxt = null;
         _info = null;
         _cradInfo = null;
         _picBmp = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
