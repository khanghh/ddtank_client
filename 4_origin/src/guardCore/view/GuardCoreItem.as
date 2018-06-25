package guardCore.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import guardCore.GuardCoreManager;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreItem extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _guardBtn:TextButton;
      
      private var _info:GuardCoreInfo;
      
      private var _type:int;
      
      private var _tips:Component;
      
      private var _frameFilter:Array;
      
      private var _clickTime:int;
      
      public function GuardCoreItem(type:int)
      {
         super();
         _type = type;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(ComponentSetting.SIMPLE_BITMAP_BUTTON_FILTER);
         _icon = ComponentFactory.Instance.creatBitmap("asset.guardCore.icon" + _type);
         var _loc1_:* = 0.8;
         _icon.scaleY = _loc1_;
         _icon.scaleX = _loc1_;
         addChild(_icon);
         _guardBtn = ComponentFactory.Instance.creatComponentByStylename("guardCore.itemBtn");
         _guardBtn.text = LanguageMgr.GetTranslation("guardCore.title");
         addChild(_guardBtn);
         _tips = ComponentFactory.Instance.creatComponentByStylename("guardCore.itemTips");
         _tips.graphics.beginFill(0,0);
         _tips.graphics.drawRect(0,0,_icon.width,_icon.height);
         _tips.graphics.endFill();
         _tips.width = _icon.width;
         _tips.height = _icon.height;
         addChild(_tips);
         updateView();
         updateTipsData();
      }
      
      public function updateTipsData() : void
      {
         var grade:int = PlayerManager.Instance.Self.Grade;
         var guardGrade:int = PlayerManager.Instance.Self.guardCoreGrade;
         _tips.tipData = {
            "type":_type,
            "grade":grade,
            "guardGrade":guardGrade
         };
      }
      
      private function updateView() : void
      {
         if(GuardCoreManager.instance.getGuardCoreIsOpen(PlayerManager.Instance.Self.Grade,_type))
         {
            _icon.filters = _frameFilter[0];
            _guardBtn.visible = true;
         }
         else
         {
            _icon.filters = _frameFilter[3];
            _guardBtn.visible = false;
         }
      }
      
      private function __onGuardBtn(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(getTimer() - _clickTime < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.poultry.wakefeedLimitTxt"));
         }
         _clickTime = getTimer();
         var info:GuardCoreInfo = GuardCoreManager.instance.getGuardCoreInfo(PlayerManager.Instance.Self.guardCoreGrade,_type);
         if(PlayerManager.Instance.Self.guardCoreID == info.ID)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.notEquip"));
         }
         else
         {
            SocketManager.Instance.out.sendGuardCoreEquip(info.ID);
         }
      }
      
      private function initEvent() : void
      {
         _guardBtn.addEventListener("click",__onGuardBtn);
      }
      
      private function removeEvent() : void
      {
         _guardBtn.removeEventListener("click",__onGuardBtn);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _info = null;
         _icon = null;
         _tips = null;
      }
   }
}
