package hall.hallInfo.playerInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class PlayerVIP extends Sprite
   {
       
      
      private var _expSprite:Sprite;
      
      private var _mask:Sprite;
      
      private var _expBitmap:Bitmap;
      
      private var _expBitmapTip:ScaleFrameImage;
      
      private var _expText:FilterFrameText;
      
      private var _selfInfo:SelfInfo;
      
      private var _vipBtn:ScaleFrameImage;
      
      private var _levelNum:ScaleFrameImage;
      
      public function PlayerVIP()
      {
         super();
         _selfInfo = PlayerManager.Instance.Self;
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _vipBtn.addEventListener("click",__showVipFrame);
         PlayerManager.Instance.addEventListener("VIPStateChange",__isOpenBtn);
      }
      
      protected function __isOpenBtn(param1:Event) : void
      {
         _selfInfo = PlayerManager.Instance.Self;
         setVIPProgress();
         setVIPState();
      }
      
      private function initView() : void
      {
         _expSprite = new Sprite();
         addChild(_expSprite);
         _expBitmap = ComponentFactory.Instance.creat("asset.hall.playerInfo.expVIP");
         _expSprite.addChild(_expBitmap);
         _expBitmapTip = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.expVIP");
         addChild(_expBitmapTip);
         _expBitmapTip.alpha = 0;
         createMask();
         _expText = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.expTxt");
         addChild(_expText);
         setVIPProgress();
         _vipBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.vipBtn");
         _vipBtn.buttonMode = true;
         addChild(_vipBtn);
         _levelNum = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.vipLevel");
         _levelNum.mouseEnabled = false;
         _levelNum.visible = false;
         addChild(_levelNum);
         setVIPState();
      }
      
      private function setVIPState() : void
      {
         if(_selfInfo.IsVIP)
         {
            _vipBtn.setFrame(2);
            _levelNum.visible = true;
            _levelNum.setFrame(_selfInfo.VIPLevel);
         }
         else
         {
            _vipBtn.setFrame(1);
         }
      }
      
      private function createMask() : void
      {
         _mask = new Sprite();
         _mask.graphics.beginFill(0,0);
         _mask.graphics.drawRect(0,0,_expBitmap.width,_expBitmap.height);
         _mask.graphics.endFill();
         addChild(_mask);
         _expSprite.mask = _mask;
      }
      
      private function setVIPProgress() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = _selfInfo.VIPLevel;
         if(_loc4_ == 15)
         {
            _loc1_ = ServerConfigManager.instance.VIPExpNeededForEachLv[11] - ServerConfigManager.instance.VIPExpNeededForEachLv[10];
            setProgress(1,1);
            _expText.text = _loc1_ + "/" + _loc1_;
         }
         else
         {
            _loc3_ = _selfInfo.VIPExp - ServerConfigManager.instance.VIPExpNeededForEachLv[_loc4_ - 1];
            _loc2_ = ServerConfigManager.instance.VIPExpNeededForEachLv[_loc4_] - ServerConfigManager.instance.VIPExpNeededForEachLv[_loc4_ - 1];
            setProgress(_loc3_,_loc2_);
            _expText.text = _loc3_ + "/" + _loc2_;
         }
         setExpTipData();
      }
      
      private function setExpTipData() : void
      {
         var _loc1_:int = 0;
         if(_selfInfo.VIPLevel != 15 && _selfInfo.IsVIP)
         {
            _loc1_ = ServerConfigManager.instance.VIPExpNeededForEachLv[_selfInfo.VIPLevel] - _selfInfo.VIPExp;
            _expBitmapTip.tipData = LanguageMgr.GetTranslation("ddt.vip.dueTime.tip",_loc1_,_selfInfo.VIPLevel + 1);
         }
         else if(!_selfInfo.IsVIP)
         {
            _expBitmapTip.tipData = LanguageMgr.GetTranslation("ddt.vip.vipIcon.reduceVipExp");
         }
         else
         {
            _expBitmapTip.tipData = LanguageMgr.GetTranslation("ddt.vip.vipIcon.upGradFull");
         }
         if(!_selfInfo.IsVIP && _selfInfo.VIPExp <= 0)
         {
            _expBitmapTip.tipData = LanguageMgr.GetTranslation("ddt.vip.vipFrame.youarenovip");
         }
      }
      
      private function setProgress(param1:int, param2:int) : void
      {
         _mask.x = -(_expBitmap.width - param1 * _expBitmap.width / param2);
      }
      
      private function __showVipFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         VipController.instance.show();
      }
      
      private function removeEvent() : void
      {
         _vipBtn.removeEventListener("click",__showVipFrame);
         PlayerManager.Instance.removeEventListener("VIPStateChange",__isOpenBtn);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
