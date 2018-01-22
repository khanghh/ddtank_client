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
         var _loc4_:int = 0;
         var _loc1_:* = null;
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
         var _loc3_:Vector.<Object> = YYVipControl.instance.openViewAwardList;
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = new YYVipAwardCell(_loc3_[_loc4_]);
            _loc1_.x = 52 + 108 * _loc4_;
            _loc1_.y = 102;
            addChild(_loc1_);
            _awardList.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",getClickHandler,false,0,true);
         _openBtn.addEventListener("click",openClickHandler,false,0,true);
      }
      
      private function openClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         YYVipControl.instance.gotoOpenUrl();
      }
      
      private function getClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["uid"] = PlayerManager.Instance.Self.ID;
         _loc3_["type"] = "2";
         _loc3_["reward"] = "1";
         var _loc2_:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ProxyVIP.ashx"),6,_loc3_);
         _loc2_.addEventListener("loadError",__onRequestError,false,0,true);
         _loc2_.addEventListener("complete",__onRequestComplete,false,0,true);
         LoadResourceManager.Instance.startLoad(_loc2_);
         _getBtn.enable = false;
      }
      
      private function __onRequestError(param1:LoaderEvent) : void
      {
         trace("RequestError");
         var _loc2_:RequestLoader = param1.target as RequestLoader;
         _loc2_.removeEventListener("loadError",__onRequestError);
         _loc2_.removeEventListener("complete",__onRequestComplete);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
      }
      
      private function __onRequestComplete(param1:LoaderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:RequestLoader = param1.target as RequestLoader;
         _loc3_.removeEventListener("loadError",__onRequestError);
         _loc3_.removeEventListener("complete",__onRequestComplete);
         var _loc4_:XML = new XML(param1.loader.content);
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_.@Type;
            if(_loc5_ == 2)
            {
               _loc2_ = _loc4_.@Reward;
               if(_loc2_ == 1)
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
      
      public function refreshOpenOrCostBtn(param1:int, param2:int) : void
      {
         if(!_openBtn || !_getBtn)
         {
            return;
         }
         if(param1 == 0)
         {
            _openBtn.enable = true;
         }
         else
         {
            _openBtn.enable = false;
         }
         if(param2 == 0)
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
