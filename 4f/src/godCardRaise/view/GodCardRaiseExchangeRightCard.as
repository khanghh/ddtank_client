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
      
      public function GodCardRaiseExchangeRightCard(param1:Object){super();}
      
      private function initView() : void{}
      
      private function __picComplete(param1:LoaderEvent) : void{}
      
      public function updateView() : void{}
      
      public function dispose() : void{}
   }
}
