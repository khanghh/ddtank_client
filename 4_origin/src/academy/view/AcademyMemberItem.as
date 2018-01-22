package academy.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class AcademyMemberItem extends Sprite implements Disposeable
   {
       
      
      private var _itembg:ScaleFrameImage;
      
      private var _line1:ScaleBitmapImage;
      
      private var _line2:ScaleBitmapImage;
      
      private var _line3:ScaleBitmapImage;
      
      private var _itemEffect:ScaleFrameImage;
      
      private var _OnlineIcon:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _levelIcon:LevelIcon;
      
      private var _info:AcademyPlayerInfo;
      
      private var _selected:Boolean;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _index:int;
      
      public function AcademyMemberItem(param1:int)
      {
         _index = param1;
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         this.buttonMode = true;
         _itembg = ComponentFactory.Instance.creatComponentByStylename("ddtacademy.rightview.signalLineBg");
         _index % 2 == 0?_itembg.setFrame(1):_itembg.setFrame(2);
         addChild(_itembg);
         _line1 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.formIine1");
         addChild(_line1);
         _line2 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.formIine2");
         addChild(_line2);
         _line3 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.formIine3");
         addChild(_line3);
         _itemEffect = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyMemberListView.itemEffect");
         addChild(_itemEffect);
         _itemEffect.visible = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyMemberItem.nameTxt");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyMemberItem.fightPowerTxt");
         addChild(_fightPowerTxt);
         _OnlineIcon = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyMemberListView.state_icon");
         _OnlineIcon.setFrame(2);
         addChild(_OnlineIcon);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("academy.AcademyMemberItem.levelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__onMouseOver);
         addEventListener("mouseOut",__onMouseClick);
      }
      
      private function __onMouseClick(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            _itemEffect.visible = false;
         }
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            _itemEffect.visible = true;
         }
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         if(_selected != param1)
         {
            _selected = param1;
            _itemEffect.visible = _selected;
         }
      }
      
      public function get isSelect() : Boolean
      {
         return _selected;
      }
      
      private function updateComponentPos() : void
      {
         if(_info.info.Grade >= 21)
         {
            _fightPowerTxt.x = PositionUtils.creatPoint("academy.AcademyMemberListView").x;
            _levelIcon.x = PositionUtils.creatPoint("academy.AcademyMemberListViewII").x;
         }
         else
         {
            _fightPowerTxt.x = PositionUtils.creatPoint("academy.AcademyMemberListView").y;
            _levelIcon.x = PositionUtils.creatPoint("academy.AcademyMemberListViewII").y;
         }
      }
      
      private function updateInfo() : void
      {
         var _loc1_:PlayerInfo = info.info;
         _nameTxt.text = _loc1_.NickName;
         _fightPowerTxt.text = String(_loc1_.FightPower);
         _levelIcon.setInfo(_loc1_.Grade,_loc1_.ddtKingGrade,_loc1_.Repute,_loc1_.WinCount,_loc1_.TotalCount,_loc1_.FightPower,_loc1_.Offer,true,false);
         if(_loc1_.playerState.StateID != 0)
         {
            _OnlineIcon.setFrame(1);
         }
         else
         {
            _OnlineIcon.setFrame(2);
         }
         if(_loc1_.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(115,_loc1_.typeVIP);
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = _nameTxt.text;
            addChild(_vipName);
            addChild(_nameTxt);
            PositionUtils.adaptNameStyle(_loc1_,_nameTxt,_vipName);
         }
         else
         {
            addChild(_nameTxt);
            _nameTxt.visible = true;
            DisplayUtils.removeDisplay(_vipName);
         }
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(info.info.isAttest)
         {
            if(_attestBtn == null)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               addChild(_attestBtn);
            }
            if(info.info.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y - 7;
            }
            else
            {
               _attestBtn.x = _nameTxt.x + _nameTxt.width;
               _attestBtn.y = _nameTxt.y - 7;
            }
            _attestBtn.visible = true;
         }
         else if(_attestBtn != null)
         {
            _attestBtn.visible = false;
         }
      }
      
      public function set info(param1:AcademyPlayerInfo) : void
      {
         _info = param1;
         updateInfo();
         updateComponentPos();
      }
      
      public function get info() : AcademyPlayerInfo
      {
         return _info;
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseOver",__onMouseOver);
         removeEventListener("mouseOut",__onMouseClick);
         if(_itemEffect)
         {
            ObjectUtils.disposeObject(_itemEffect);
            _itemEffect = null;
         }
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = null;
         }
         if(_fightPowerTxt)
         {
            ObjectUtils.disposeObject(_fightPowerTxt);
            _fightPowerTxt = null;
         }
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
            _levelIcon = null;
         }
         if(_OnlineIcon)
         {
            ObjectUtils.disposeObject(_OnlineIcon);
            _OnlineIcon = null;
         }
         if(_attestBtn)
         {
            ObjectUtils.disposeObject(_attestBtn);
            _attestBtn = null;
         }
      }
   }
}
