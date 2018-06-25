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
      
      public function AcademyMemberItem(index:int)
      {
         _index = index;
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
      
      private function __onMouseClick(event:MouseEvent) : void
      {
         if(!_selected)
         {
            _itemEffect.visible = false;
         }
      }
      
      private function __onMouseOver(event:MouseEvent) : void
      {
         if(!_selected)
         {
            _itemEffect.visible = true;
         }
      }
      
      public function set isSelect(value:Boolean) : void
      {
         if(_selected != value)
         {
            _selected = value;
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
         var player:PlayerInfo = info.info;
         _nameTxt.text = player.NickName;
         _fightPowerTxt.text = String(player.FightPower);
         _levelIcon.setInfo(player.Grade,player.ddtKingGrade,player.Repute,player.WinCount,player.TotalCount,player.FightPower,player.Offer,true,false);
         if(player.playerState.StateID != 0)
         {
            _OnlineIcon.setFrame(1);
         }
         else
         {
            _OnlineIcon.setFrame(2);
         }
         if(player.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(115,player.typeVIP);
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = _nameTxt.text;
            addChild(_vipName);
            addChild(_nameTxt);
            PositionUtils.adaptNameStyle(player,_nameTxt,_vipName);
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
      
      public function set info(info:AcademyPlayerInfo) : void
      {
         _info = info;
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
