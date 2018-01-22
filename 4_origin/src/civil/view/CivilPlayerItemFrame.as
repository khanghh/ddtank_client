package civil.view
{
   import civil.CivilEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class CivilPlayerItemFrame extends Sprite implements Disposeable
   {
       
      
      private var _info:CivilPlayerInfo;
      
      private var _level:int = 1;
      
      private var _levelIcon:LevelIcon;
      
      private var _isSelect:Boolean;
      
      private var _selectEffect:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _stateIcon:ScaleFrameImage;
      
      private var _bg:ScaleFrameImage;
      
      private var _line1:ScaleBitmapImage;
      
      private var _line2:ScaleBitmapImage;
      
      private var _selected:Boolean = false;
      
      private var _index:int;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function CivilPlayerItemFrame(param1:int)
      {
         buttonMode = true;
         _index = param1;
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.rightview.signalLineBg");
         _index % 2 == 0?_bg.setFrame(1):_bg.setFrame(2);
         addChild(_bg);
         _line1 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.formIine1");
         addChild(_line1);
         _line2 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.formIine2");
         addChild(_line2);
         _selectEffect = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.rightview.signalLine.selected");
         addChild(_selectEffect);
         _selectEffect.visible = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.SelectBGPlayerName");
         _levelIcon = ComponentFactory.Instance.creatCustomObject("ddtcivil.levelIcon_list");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _stateIcon = ComponentFactory.Instance.creat("ddtcivil.state_icon");
         addChild(_stateIcon);
      }
      
      public function set info(param1:CivilPlayerInfo) : void
      {
         _info = param1;
         upView();
         addEvent();
      }
      
      public function get info() : CivilPlayerInfo
      {
         return _info;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__overHandle);
         addEventListener("mouseOut",__outHandle);
         PlayerManager.Instance.Self.addEventListener("propertychange",__offerChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandle);
         removeEventListener("mouseOut",__outHandle);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__offerChange);
      }
      
      private function __offerChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["isVip"])
         {
            upView();
         }
      }
      
      private function __clickHandle(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new CivilEvent("selectclickitem",this));
      }
      
      private function __overHandle(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            _selectEffect.visible = true;
         }
      }
      
      private function __outHandle(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            _selectEffect.visible = false;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected != param1)
         {
            _selected = param1;
            _selectEffect.visible = _selected;
         }
      }
      
      private function upView() : void
      {
         _nameTxt.text = _info.info.NickName;
         if(_info.info.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(169,_info.info.typeVIP);
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = _nameTxt.text;
            addChild(_vipName);
            addChild(_nameTxt);
            PositionUtils.adaptNameStyle(_info.info,_nameTxt,_vipName);
         }
         else
         {
            addChild(_nameTxt);
            DisplayUtils.removeDisplay(_vipName);
         }
         _levelIcon.setInfo(_info.info.Grade,_info.info.ddtKingGrade,_info.info.Repute,_info.info.WinCount,_info.info.TotalCount,_info.info.FightPower,_info.info.Offer,true,false);
         if(_info.info.Sex)
         {
            _stateIcon.setFrame(!!_info.info.playerState.StateID?1:3);
         }
         else
         {
            _stateIcon.setFrame(!!_info.info.playerState.StateID?2:3);
         }
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(_info.info.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            _attestBtn.buttonMode = true;
            addChild(_attestBtn);
            if(_info.info.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y - 6;
            }
            else
            {
               _attestBtn.x = _nameTxt.x + _nameTxt.width;
               _attestBtn.y = _nameTxt.y - 6;
            }
         }
      }
      
      override public function get height() : Number
      {
         if(_bg == null)
         {
            return 0;
         }
         return _bg.y + _bg.height;
      }
      
      public function dispose() : void
      {
         _info = null;
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_selectEffect)
         {
            ObjectUtils.disposeObject(_selectEffect);
         }
         _selectEffect = null;
         ObjectUtils.disposeObject(_stateIcon);
         _stateIcon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_attestBtn);
         _attestBtn = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
