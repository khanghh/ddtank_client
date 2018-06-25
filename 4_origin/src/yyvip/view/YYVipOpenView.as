package yyvip.view
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import yyvip.YYVipControl;
   
   public class YYVipOpenView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _awardList:Vector.<YYVipAwardCell>;
      
      public function YYVipOpenView()
      {
         super();
         this.x = 2;
         this.y = -8;
         this.mouseEnabled = false;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.yyvip.openView.bg");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("yyvip.view.getBtn");
         _getBtn.enable = false;
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("yyvip.view.openBtn");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("yyvip.openView.tipTxt");
         _tipTxt.text = LanguageMgr.GetTranslation("yyVip.openView.tipTxt");
         addChild(_bg);
         addChild(_getBtn);
         addChild(_openBtn);
         addChild(_tipTxt);
         _awardList = new Vector.<YYVipAwardCell>();
         var tmpAwardInfoList:Vector.<Object> = YYVipControl.instance.openViewAwardList;
         var len:int = tmpAwardInfoList.length;
         for(i = 0; i < len; )
         {
            tmp = new YYVipAwardCell(tmpAwardInfoList[i]);
            tmp.x = 52 + 108 * i;
            tmp.y = 102;
            addChild(tmp);
            _awardList.push(tmp);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",getClickHandler,false,0,true);
         _openBtn.addEventListener("click",openClickHandler,false,0,true);
      }
      
      private function openClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         YYVipControl.instance.gotoOpenUrl();
      }
      
      private function getClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var args:URLVariables = new URLVariables();
         args["uid"] = PlayerManager.Instance.Self.ID;
         args["type"] = "2";
         args["reward"] = "1";
         var loader:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ProxyVIP.ashx"),6,args);
         loader.addEventListener("loadError",__onRequestError,false,0,true);
         loader.addEventListener("complete",__onRequestComplete,false,0,true);
         LoadResourceManager.Instance.startLoad(loader);
         _getBtn.enable = false;
      }
      
      private function __onRequestError(evt:LoaderEvent) : void
      {
         trace("RequestError");
         var tmpLoader:RequestLoader = evt.target as RequestLoader;
         tmpLoader.removeEventListener("loadError",__onRequestError);
         tmpLoader.removeEventListener("complete",__onRequestComplete);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
      }
      
      private function __onRequestComplete(evt:LoaderEvent) : void
      {
         var type:int = 0;
         var result:int = 0;
         var tmpLoader:RequestLoader = evt.target as RequestLoader;
         tmpLoader.removeEventListener("loadError",__onRequestError);
         tmpLoader.removeEventListener("complete",__onRequestComplete);
         var xml:XML = new XML(evt.loader.content);
         if(xml.@value == "true")
         {
            type = xml.@Type;
            if(type == 2)
            {
               result = xml.@Reward;
               if(result == 1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.getReward.successTxt"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.getReward.failTxt"));
               }
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
         }
      }
      
      public function refreshOpenOrCostBtn(isVip:int, isCanGet:int) : void
      {
         if(!_openBtn || !_getBtn)
         {
            return;
         }
         if(isVip == 0)
         {
            _openBtn.enable = true;
         }
         else
         {
            _openBtn.enable = false;
         }
         if(isCanGet == 0)
         {
            _getBtn.enable = false;
         }
         else
         {
            _getBtn.enable = true;
         }
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",getClickHandler);
         _openBtn.removeEventListener("click",openClickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _getBtn = null;
         _openBtn = null;
         _awardList = null;
         _tipTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
