package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.FilterFrameTextWithTips;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import ddt.data.ConsortiaInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import road7th.utils.StringHelper;
   import vip.VipController;
   
   public class ConsortionInfoView extends Sprite implements Disposeable
   {
       
      
      private var _badgeBtn:BuyBadgeButton;
      
      private var _shopIcon:BuildingLevelItem;
      
      private var _storeIcon:BuildingLevelItem;
      
      private var _bankIcon:BuildingLevelItem;
      
      private var _skillIcon:BuildingLevelItem;
      
      private var _infoWordBG:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _consortionName:FilterFrameText;
      
      private var _level:ScaleFrameImage;
      
      private var _consortionNameInput:FilterFrameText;
      
      private var _chairmanName:FilterFrameText;
      
      private var _vipChairman:GradientText;
      
      private var _count:FilterFrameText;
      
      private var _riches:FilterFrameText;
      
      private var _honor:FilterFrameText;
      
      private var _repute:FilterFrameText;
      
      private var _weekPay:FilterFrameTextWithTips;
      
      private var _consortiaInfo:ConsortiaInfo;
      
      private var _BG2:ScaleBitmapImage;
      
      private var _chairmanText:FilterFrameText;
      
      private var _numberText:FilterFrameText;
      
      private var _richesText:FilterFrameText;
      
      private var _exploitText:FilterFrameText;
      
      private var _rankingText:FilterFrameText;
      
      private var _holdText:FilterFrameText;
      
      private var _chairmanTextInputBg:Scale9CornerImage;
      
      private var _numberTextInputBg:Scale9CornerImage;
      
      private var _richesTextInputBg:Scale9CornerImage;
      
      private var _exploitTextInputBg:Scale9CornerImage;
      
      private var _rankingTextInputBg:Scale9CornerImage;
      
      private var _holdTextInputBg:Scale9CornerImage;
      
      private var _activeBtn:SimpleBitmapButton;
      
      private var _activeBg:ScaleLeftRightImage;
      
      public function ConsortionInfoView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onGetConsortiaInfoRes(param1:Event) : void{}
      
      private function onClickActiveBtn(param1:MouseEvent) : void{}
      
      private function onActiveRes(param1:Event) : void{}
      
      private function _levelUpRuleChange(param1:ConsortionEvent) : void{}
      
      private function _consortiaInfoChange(param1:PlayerPropertyEvent) : void{}
      
      private function __consortiaInfoPropChange(param1:PlayerPropertyEvent) : void{}
      
      private function setWeekyPay() : void{}
      
      private function set consortionInfo(param1:ConsortiaInfo) : void{}
      
      public function dispose() : void{}
   }
}
